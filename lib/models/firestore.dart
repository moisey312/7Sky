import 'package:cloud_firestore/cloud_firestore.dart';

final databaseReference = Firestore.instance;

class FireStoreFuns {
  static String name='';
  static String id;
  static String email='';
  static int typeId;
  static String city = '';
  static String number='';
  static double rating;
  static String password;
  static String price;
  static void registration() async {
    print(id);
    await databaseReference.collection("users").document(id).setData({
      'name': name,
      'email': email,
      'typeId': typeId,
      'city': city,
      'number': number,
      'rating': 0,
      'password': password

    });
    if(typeId!=0){
      await databaseReference.collection("users").document(id).setData({
        'price': price
      });
    }
  }


  static void getProfile() async {
    DocumentReference data = databaseReference.collection('users').document(id);
    await data.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        email = datasnapshot.data['email'].toString();
        number = datasnapshot.data['number'].toString();
        name = datasnapshot.data['name'].toString();
        typeId = datasnapshot.data['typeId'];
        rating = datasnapshot.data['rating'];
        city = datasnapshot.data['city'];
      } else {
        print(id);
        print("No such user");
      }
    });
  }
}
