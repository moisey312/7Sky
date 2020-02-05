import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:testproj/models/firestore.dart';
import 'package:multi_image_picker/src/asset.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

String _uploadedFileURL;

class Storage {
  static String user_photo_url;
  static Future uploadPortfolioPhoto(List<Asset> a ) async{

    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child(Database.myProfile['id'].toString() + '/portfolio/'+a.elementAt(0).name);

    //StorageUploadTask uploadTask = storageReference.putFile();
    //await uploadTask.onComplete;
    print('File Uploaded');

  }
  static Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  static Future getUrlUserPhoto(String id)async{
    final ref = FirebaseStorage.instance.ref().child('/'+id+'/'+Database.myProfile['user_photo_name']);
    var url = await ref.getDownloadURL();
    user_photo_url = url;
  }
  static Future<String> getUrlProfileImage(String id, String fileName)async{
    final ref = FirebaseStorage.instance.ref().child('/'+id+'/'+fileName);
    var url = await ref.getDownloadURL();
    return url;
  }
  static Future<String> getUrlPortfolio(String id, String fileName)async{
    final ref = FirebaseStorage.instance.ref().child('/'+id + '/portfolio/'+fileName);
    var url = await ref.getDownloadURL();
    return url;
  }
}