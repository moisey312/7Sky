import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testproj/list_of_gallery.dart';

final databaseReference = Firestore.instance;

class Database {
  static String name = '';
  static String id;
  static String email = '';
  static int typeId;
  static String city = '';
  static String number = '';
  static double rating;
  static String password;
  static String price;
  static List favorites;
  static List portfolioImageNames;
  static void registration() async {
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
        'price': price,
        'portfolio_image_names':[]
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
  static void setPortfolioImageNames(String file)async{
    portfolioImageNames.add(file);
    await databaseReference.collection('users').document(id).setData({
      'portfolio_image_names': portfolioImageNames
    });
  }
  static void setFavorites()async{
    await databaseReference.collection("users").document(id).setData({
      'favorites':favorites
    });
  }
  static void getPortfolioImageNames()async{
    await databaseReference.collection('users').document(id).get().then((snapshot){
      if(snapshot.exists){
        portfolioImageNames = snapshot.data['portfolio_image_names'].toList();
      }
    });
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
    if(typeId!=0){
      await data.get().then((datasnapshot){
        if(datasnapshot.exists){
          price = datasnapshot.data['price'];
          portfolioImageNames = datasnapshot.data['portfolio_image_names'].toList();
        }
      });
    }
  }

  static getPhotographerAndStudioIds() async {
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
    ListOfGallery.photographersAndStudios = list;
  }

  static Future<Map<String, Object>> getUserProfile(String id) async {
    Map<String, Object> info = new Map();
    await databaseReference
        .collection('users')
        .document(id)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        info['email']=snapshot.data['email'].toString();
        info['name']=snapshot.data['name'].toString();
        info['typeId'] = snapshot.data['typeId'];
        info['rating'] = snapshot.data['rating'];
        info['city'] = snapshot.data['city'].toString();
        info['price'] = snapshot.data['price'].toString();
        info['portfolio_image_names'] = snapshot.data['portfolio_image_names'].toList();
      } else {
        print(id);
        print("No such user");
      }
    });
    return info;
  }
}
