import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testproj/list_of_gallery.dart';
final databaseReference = Firestore.instance;

class FireStoreFuns {
  static String name = '';
  static String id;
  static String email = '';
  static int typeId;
  static String city = '';
  static String number = '';
  static double rating;
  static String password;
  static String price;
  static List<String> favorites;

  static void registration() async {
    print(id);

    if (typeId != 0) {
      await databaseReference.collection("users").document(id).setData({
        'name': name,
        'email': email,
        'typeId': typeId,
        'city': city,
        'number': number,
        'rating': 0.0,
        'favorites': [],
        'password': password,
        'price': price
      });
    } else {
      await databaseReference.collection("users").document(id).setData({
        'name': name,
        'email': email,
        'typeId': typeId,
        'city': city,
        'number': number,
        'favorites': [],
        'rating': 1.0,
        'password': password
      });
    }
  }

  static void getMyProfile() async {
    DocumentReference data = databaseReference.collection('users').document(id);
    await data.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        email = datasnapshot.data['email'].toString();
        number = datasnapshot.data['number'].toString();
        name = datasnapshot.data['name'].toString();
        typeId = datasnapshot.data['typeId'];
        rating = datasnapshot.data['rating'];
        city = datasnapshot.data['city'];
        favorites = datasnapshot.data['favorites'];
      } else {
        print(id);
        print("No such user");
      }
    });
  }

  static getPhotographersAndStudiosId() async {
    List<String> list = [];
    await databaseReference
        .collection('users')
        .where("typeId", isEqualTo: 1)
        .snapshots()
        .listen((data) => data.documents.forEach((doc) => list.add(doc.documentID)));
    await databaseReference
        .collection('users')
        .where("typeId", isEqualTo: 2)
        .snapshots()
        .listen((data) => data.documents.forEach((doc) => list.add(doc.documentID)));
    ListOfGallery.PhotographersAndStudios = list;
  }

  static Future<HashMap<String,String>> getUserProfile(String id) async {
    databaseReference.collection('user').document(id);
    HashMap<String, String> info = {};
    info.addEntries('name','name')

  }
}
