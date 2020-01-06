import 'package:cloud_firestore/cloud_firestore.dart';

final databaseReference = Firestore.instance;
class FireStoreFuns{
  static String name;
  static String id;
  static String email;
  static int typeId;
  static String city;
  static void registration(String id, String name, String email, int typeId) async{
    await databaseReference.collection("users")
        .document(id)
        .setData({
      'name': name,
      'email': email,
      'typeId': typeId,

    });
  }
  static String getProfile(){
    return "";
  }
}