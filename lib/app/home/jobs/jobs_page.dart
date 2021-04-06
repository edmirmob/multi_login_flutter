import 'package:flutter/material.dart';
import 'package:multi_login_flutter/app/home/job_entries/job_entries_page.dart';
import 'package:multi_login_flutter/app/home/jobs/edit_job_page.dart';
import 'package:multi_login_flutter/app/home/jobs/job_list_tile.dart';
import 'package:multi_login_flutter/app/home/jobs/list_items_builder.dart';
import 'package:multi_login_flutter/app/home/models.dart/job.dart';
import 'package:multi_login_flutter/common_widgets/platform_alert_dialog.dart';
import 'package:multi_login_flutter/services/auth.dart';
import 'package:multi_login_flutter/services/database.dart';
import 'package:provider/provider.dart';

class JobsPage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final _didChangedPlatform = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (_didChangedPlatform == true) {
      _signOut(context);
    }
  }

   Future<void>_delete(BuildContext context, Job job)async {
     try {
     final database = context.read<DataBase>();
     await database.deleteJob(job);
       
     } catch (e) {
       PlatformAlertDialog(
          title: 'Operation failed',
          content: e.toString(),
          defaultActionText: 'OK',
        ).show(context);
     }
     
}
  @override
  Widget build(BuildContext context) {
    final databaseProvide = context.read<DataBase>();
    databaseProvide.jobsStream();
    return Scaffold(
      appBar: AppBar(title: Text('Jobs'), actions: [
        TextButton(
          onPressed: () => _confirmSignOut(context),
          child: Text(
            'Logout',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ]),
      body: _buildContents(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => EditJobPage.show(context),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    final readProvider = context.read<DataBase>();

    // ignore: missing_required_param
    return StreamBuilder<List<Job>>(
      stream: readProvider.jobsStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Job>(
          snapshot: snapshot,
          itemBuilder: (context, job) => Dismissible(
            key: Key('job-${job.id}'),
            background: Container(color:Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (direction)=>_delete(context,job),
                                  child: JobListTile(
                          job: job,
                          onTap: () => JobEntriesPage.show(context,job),
                        ),
                      ),
                    );
                  },
                );
              }
            }
            
