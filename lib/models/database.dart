import 'package:cloud_firestore/cloud_firestore.dart';

final databaseReference = Firestore.instance;
class Registration{
  static void registration(String id, String name, String email) async{
    await databaseReference.collection("users")
        .document(id)
        .setData({
      'name': name,
      'email': email
    });
  }
}
