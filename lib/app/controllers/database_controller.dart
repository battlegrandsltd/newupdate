import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class DatabaseController extends GetxController {
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  Future<void> setData(String path, Map<String, dynamic> data) async {
    await _firebaseDatabase.ref().child(path).set(data);
  }

  Future<void> updateData(String path, Map<String, dynamic> data) async {
    await _firebaseDatabase.ref().child(path).update(data);
  }

  void deleteData(String path) {
    _firebaseDatabase.ref().child(path).remove();
  }

  Future<dynamic> getData(String path) async {
    DatabaseEvent event = await _firebaseDatabase.ref().child(path).once();
    return event.snapshot.value;
  }

  Stream getStream(String path) {
    return _firebaseDatabase.ref().child(path).onValue;
  }
}
