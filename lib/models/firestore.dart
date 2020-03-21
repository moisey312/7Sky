import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testproj/list_of_gallery.dart';
import 'package:testproj/main.dart';
import 'package:testproj/models/storage.dart';
import 'package:testproj/pages/galery_page.dart';

final databaseReference = Firestore.instance;

class Database {
  static Map<String, Object> myProfile = new Map();

  static void registration() async {
    if (myProfile['typeId'] != 0) {
      await databaseReference
          .collection("users")
          .document(myProfile['id'])
          .setData({
        'name': myProfile['name'],
        'email': myProfile['email'],
        'typeId': myProfile['typeId'],
        'city': myProfile['city'],
        'number': myProfile['number'],
        'rating': 0.0,
        'favorites': new List<String>(),
        'password': myProfile['password'],
        'price': myProfile['price'],
        'portfolio_image_names': new List<String>()
      });
    } else {
      await databaseReference
          .collection("users")
          .document(myProfile['id'])
          .setData({
        'name': myProfile['name'],
        'email': myProfile['email'],
        'typeId': myProfile['typeId'],
        'city': myProfile['city'],
        'number': myProfile['number'],
        'favorites': [],
        'rating': 0.0,
        'password': myProfile['password']
      });

      await databaseReference
          .collection('users')
          .document(myProfile['id'])
          .updateData({
        'user_photo_name': myProfile.containsKey('user_photo_name')
            ? myProfile['user_photo_name']
            : ''
      });
    }
  }

  static void setPortfolioImageNames(String file) async {
    List<dynamic> list = myProfile['portfolio_image_names'];
    list.add(file);
    myProfile['portfolio_image_names'] = list;
    await databaseReference
        .collection('users')
        .document(myProfile['id'])
        .updateData(
            {'portfolio_image_names': myProfile['portfolio_image_names']});
  }

  static void setUserPhotoName(String id, String name) async {
    await databaseReference
        .collection("users")
        .document(id)
        .updateData({'user_photo_name': name});
  }

  static void setFavorites() async {
    await databaseReference
        .collection("users")
        .document(myProfile['id'])
        .updateData({'favorites': myProfile['favorites']});
  }

  static void getPortfolioImageNames() async {
    await databaseReference
        .collection('users')
        .document(myProfile['id'])
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        myProfile['portfolio_image_names'] =
            snapshot.data['portfolio_image_names'].toList();
      }
    });
  }

  static Future<bool> getMyProfile() async {
    DocumentReference data =
        databaseReference.collection('users').document(myProfile['id']);
    await data.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        myProfile['email'] = datasnapshot.data['email'].toString();
        myProfile['user_photo_name'] =
            datasnapshot.data['user_photo_name'].toString();
        myProfile['number'] = datasnapshot.data['number'].toString();
        myProfile['name'] = datasnapshot.data['name'].toString();
        myProfile['typeId'] = datasnapshot.data['typeId'];
        myProfile['rating'] = datasnapshot.data['rating'];
        myProfile['city'] = datasnapshot.data['city'];
        myProfile['favorites'] =
            new List<String>.from(datasnapshot.data['favorites']);
        myProfile['user_photo_name'] = datasnapshot.data['user_photo_name'];
      } else {
        print(myProfile['id']);
        print("No such user");
      }
    });
    if (myProfile['typeId'] != 0) {
      await data.get().then((datasnapshot) {
        if (datasnapshot.exists) {
          myProfile['price'] = datasnapshot.data['price'];
          myProfile['portfolio_image_names'] =
              datasnapshot.data['portfolio_image_names'].toList();
        }
      });
    }
    await Storage.getUrlUserPhoto();
    return true;
  }

  static Future<List<String>> getPhotographerAndStudioIds() async {
    List<String> list = [];

    final photographers = await databaseReference
        .collection('users')
        .where('typeId', isEqualTo: 1)
        .getDocuments();

    final studios = await databaseReference
        .collection('users')
        .where('typeId', isEqualTo: 2)
        .getDocuments();

    final photographerIDs = photographers.documents.map((doc) {
      return doc.documentID;
    });
    final studioIDs = studios.documents.map((doc) {
      return doc.documentID;
    });
    list.addAll(photographerIDs);
    list.addAll(studioIDs);

    print(list.toString() + 'base');
    return list;
  }

  static Future<Map<String, Object>> getUserProfile(String id) async {
    Map<String, Object> info = new Map();
    await databaseReference
        .collection('users')
        .document(id)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        info['email'] = snapshot.data['email'].toString();
        info['user_photo_name'] = snapshot.data['user_photo_name'].toString();
        info['name'] = snapshot.data['name'].toString();
        info['typeId'] = snapshot.data['typeId'];
        info['rating'] = snapshot.data['rating'];
        info['number'] = snapshot.data['number'];
        info['city'] = snapshot.data['city'].toString();
        info['price'] = snapshot.data['price'].toString();
        info['user_photo_name'] = snapshot.data['user_photo_name'].toString();
        info['portfolio_image_names'] =
            snapshot.data['portfolio_image_names'].toList();
      } else {
        print(id);
        print("No such user");
      }
    });
    return info;
  }
}
