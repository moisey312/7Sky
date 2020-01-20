import 'package:flutter/material.dart';
import 'package:testproj/models/firestore.dart';
import '../style.dart';
import 'package:testproj/list_of_gallery.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key key}) : super(key: key);

  @override
  createState() => new _GalleryPage();
}

class _GalleryPage extends State<GalleryPage> with WidgetsBindingObserver{
  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    if(state == AppLifecycleState.paused){
      Database.setFavorites();
    }
    if(state==AppLifecycleState.resumed){
      Database.getPhotographersAndStudiosId();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          title: Center(
              child: Text(
            "Галерея",
            style: TextStyle(fontSize: 17),
          )),
        ),
      ),
      body: ListOfGallery.getListOfGallery(context),
    );
  }
}