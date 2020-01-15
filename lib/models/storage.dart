import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
import 'package:testproj/models/firestore.dart';

File _image;
String _uploadedFileURL;

class Storage {
  static Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      _image = image;
    });
  }
  static File get_image(){
    return _image;
  }
  static Future uploadProfilePhoto() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child(FireStoreFuns.id.toString()+ '/profile.jpg');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      _uploadedFileURL = fileURL;
    });
  }
  static create_folder(){
  }
}
