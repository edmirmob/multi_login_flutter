import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:multi_login_flutter/app/home/models.dart/job.dart';
import 'package:multi_login_flutter/services/api_path.dart';

abstract class DataBase {
  // Future<void> setJob(Job job);
  Future<void> createJob(Job job);
  // Future<void> deleteJob(Job job);

  // Future<void> setEntry(Entry job);

  // Future<void> deleteEntry(Entry job);

  Stream<List<Job>> jobsStream();

  // Stream<List<Enty>> entriesStream({Job job});
}

class FirestoreDatabase implements DataBase {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);

  final String uid;

  @override
  Future<void> createJob(Job job) async => await _setData(
        path: APIPath.job(uid, 'job_abc'),
        data: job.toMap(),
      );
  Stream<List<Job>> jobsStream() {
    final path = APIPath.jobs(uid);
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map(
      (snapshot) => snapshot.docs.map(
        (snapshot) => Job(
            name: snapshot.data()['name'],
            ratePerHour: snapshot.data()['ratePerHour']),
      ).toList(),
    );
  }

  Future<void> _setData({String path, Map<String, dynamic> data}) async {
    final documentReference = FirebaseFirestore.instance.doc(path);

    await documentReference.set(data);
  }
}
