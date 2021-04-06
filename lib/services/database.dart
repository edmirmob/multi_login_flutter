import 'package:meta/meta.dart';
import 'dart:async';
import 'package:multi_login_flutter/app/home/models.dart/job.dart';
import 'package:multi_login_flutter/services/api_path.dart';
import 'package:multi_login_flutter/services/firestore_servis.dart';

abstract class DataBase {
  // Future<void> setJob(Job job);
  Future<void> setJob(Job job);
  Future<void> deleteJob(Job job);

  // Future<void> setEntry(Entry job);

  // Future<void> deleteEntry(Entry job);

  Stream<List<Job>> jobsStream();

  // Stream<List<Enty>> entriesStream({Job job});
}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements DataBase {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  final String uid;
  final _service = FirestoreServis.instance;
  @override
  Future<void> setJob(Job job) async => await _service.setData(
        path: APIPath.job(uid, job.id),
        data: job.toMap(),
      );
  @override
  Future<void> deleteJob(Job job) async => await _service.deleteData(
        path: APIPath.job(uid, job.id),
      );
  @override
  Stream<List<Job>> jobsStream() => _service.collectionStream(
      path: APIPath.jobs(uid),
      builder: (data, documentId) {
        return Job.fromMap(data, documentId);
      });
}
