import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_login_flutter/app/home/jobs/add_job_page.dart';
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

  @override
  Widget build(BuildContext context) {
    // TODO: delete this line
    //  final readProv = Provider.of<DataBase>(context, listen: false);
    final cc = context.read<DataBase>();
    cc.jobsStream();
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
      body: _buildContext(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => AddJobPage.show(context),
      ),
    );
  }

  void _createJob(BuildContext context) async {
    try {
      final dataBase = Provider.of<DataBase>(context, listen: false);
      await dataBase.createJob(Job(name: 'Blog', ratePerHour: 27));
    } catch (e) {
      PlatformAlertDialog(
        title: 'Operation failed',
        content: e.message,
        defaultActionText: 'OK',
      ).show(context);
    }
  }

  Widget _buildContext(BuildContext context) {
    final readProvider = context.read<DataBase>();

    // ignore: missing_required_param
    return StreamBuilder<List<Job>>(
      stream: readProvider.jobsStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final jobs = snapshot.data;
          final childrens = jobs.map((job) => Text(job.name)).toList();
          return ListView(children:[
            Center(
              child: Text(childrens.toString()),
            )
          ] );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Some error occured'),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
