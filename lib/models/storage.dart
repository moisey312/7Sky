import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:testproj/models/firestore.dart';
import 'package:multi_image_picker/src/asset.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
File _image;
String _uploadedFileURL;

class Storage {
  static Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      _image = image;
    });
  }
  static File getImage(){
    return _image;
  }
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
  static Future uploadProfilePhoto() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child(Database.myProfile['id'].toString()+ '/profile.jpg');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      _uploadedFileURL = fileURL;
    });
  }
  static createFolderForId(){
  }
  static Future<String> getUrlProfileImage(String id)async{
    final ref = FirebaseStorage.instance.ref().child('/'+id+'/profile.jpg');
    var url = await ref.getDownloadURL();
    return url;
  }
  static Future<String> getUrlPortfolio(String id, String fileName)async{
    final ref = FirebaseStorage.instance.ref().child('/'+id + '/portfolio/'+fileName);
    var url = await ref.getDownloadURL();
    return url;
  }
}