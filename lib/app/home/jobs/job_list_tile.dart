import 'package:flutter/material.dart';
import 'package:multi_login_flutter/app/home/models.dart/job.dart';

class JobListTile extends StatelessWidget {

 JobListTile({Key key, @required this.job, this.onTap}) : super(key: key);

  final Job job;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(job.name),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}