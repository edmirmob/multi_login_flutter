import 'package:meta/meta.dart';
import 'package:multi_login_flutter/app/home/models.dart/entry.dart';
import 'dart:async';
import 'package:multi_login_flutter/app/home/models.dart/job.dart';
import 'package:multi_login_flutter/services/api_path.dart';
import 'package:multi_login_flutter/services/firestore_servis.dart';

abstract class DataBase {
  
  Future<void> setJob(Job job);
  Future<void> deleteJob(Job job);
  Stream<List<Job>> jobsStream();

  Future<void> setEntry(Entry job);
  Future<void> deleteEntry(Entry job);
  Stream<List<Entry>> entriesStream({Job job});

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

      @override
  Future<void> setEntry(Entry entry) async => await _service.setData(
    path: APIPath.entry(uid, entry.id),
    data: entry.toMap(),
  );

  @override
  Future<void> deleteEntry(Entry entry) async => await _service.deleteData(path: APIPath.entry(uid, entry.id));

  @override
  Stream<List<Entry>> entriesStream({Job job}) => _service.collectionStream<Entry>(
    path: APIPath.entries(uid),
    queryBuilder: job != null ? (query) => query.where('jobId', isEqualTo: job.id) : null,
    builder: (data, documentID) => Entry.fromMap(data, documentID),
    sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
  );
}
