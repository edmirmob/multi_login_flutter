import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_login_flutter/app/home/job_entries/entry_list_item.dart';
import 'package:multi_login_flutter/app/home/job_entries/entry_page.dart';
import 'package:multi_login_flutter/app/home/jobs/edit_job_page.dart';
import 'package:multi_login_flutter/app/home/jobs/list_items_builder.dart';
import 'package:multi_login_flutter/app/home/models.dart/entry.dart';
import 'package:multi_login_flutter/app/home/models.dart/job.dart';
import 'package:multi_login_flutter/common_widgets/platform_alert_dialog.dart';
import 'package:multi_login_flutter/services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class JobEntriesPage extends StatelessWidget {
  const JobEntriesPage({@required this.database, @required this.job});
  final DataBase database;
  final Job job;

  static Future<void> show(BuildContext context, Job job) async {
    final database = Provider.of<DataBase>(context, listen: false);
    await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: false,
        builder: (context) => JobEntriesPage(database: database, job: job),
      ),
    );
  }

  Future<void> _deleteEntry(BuildContext context, Entry entry) async {
    try {
      await database.deleteEntry(entry);
    } on PlatformException catch (e) {
      PlatformAlertDialog(
        title: 'Operation failed',
        content: e.toString(),
        defaultActionText: 'OK',
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Job>(
        stream: database.jobStream(jobId: job.id),
        builder: (context, snapshot) {
          final job = snapshot.data;
          final jobName = job?.name ?? '';
          return Scaffold(
            appBar: AppBar(
              elevation: 2.0,
              centerTitle: true,
              title: Text(jobName),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.white),
                  onPressed: () => EditJobPage.show(
                    context,
                    job: job,
                    database: database,
                  ),
                ),
                IconButton(
                  onPressed: () => EntryPage.show(
                      context: context, database: database, job: job),
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            body: _buildContent(context, job),
          );
        });
  }

  Widget _buildContent(BuildContext context, Job job) {
    return StreamBuilder<List<Entry>>(
      stream: database.entriesStream(job: job),
      builder: (context, snapshot) {
        return ListItemsBuilder<Entry>(
          snapshot: snapshot,
          itemBuilder: (context, entry) {
            return DismissibleEntryListItem(
              key: Key('entry-${entry.id}'),
              entry: entry,
              job: job,
              onDismissed: () => _deleteEntry(context, entry),
              onTap: () => EntryPage.show(
                context: context,
                database: database,
                job: job,
                entry: entry,
              ),
            );
          },
        );
      },
    );
  }
}
