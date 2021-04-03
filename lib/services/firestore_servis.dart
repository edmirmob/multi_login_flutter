import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class FirestoreServis{
  FirestoreServis._();
  static final instance = FirestoreServis._();
   Future<void> setData({String path, Map<String, dynamic> data}) async {
    final documentReference = FirebaseFirestore.instance.doc(path);

    await documentReference.set(data);
  }

  Stream<List<T>> collectionStream<T>(
      {@required String path, @required T builder(Map<String, dynamic> data)}) {
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map(
      (snapshot) =>
          snapshot.docs.map((snapshot) => builder(snapshot.data())).toList(),
    );
  }
}