import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';

class ShowerPhoto extends StatelessWidget {
  ShowerPhoto({this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          child: PhotoView(
            imageProvider: CachedNetworkImageProvider(url),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
          child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
        ),
      ]),
    );
  }
}
