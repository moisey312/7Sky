import 'package:flutter/material.dart';
import 'pages/profile_page.dart';
import 'pages/favorite_page.dart';
import 'pages/galery_page.dart';
import 'services/authentication.dart';

class BottomNavigationBarController extends StatefulWidget {
  BottomNavigationBarController(
      {Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _BottomNavigationBarControllerState createState() =>
      _BottomNavigationBarControllerState();
}

class _BottomNavigationBarControllerState
    extends State<BottomNavigationBarController> {
  List<Widget> pages = [
    GalleryPage(
      key: PageStorageKey('Page1'),
    ),
    FavoritePage(
      key: PageStorageKey('Page2'),
    ),
    ProfilePage(
      key: PageStorageKey('Page3')
    ),
  ];

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }
  void callsignout(){
    signOut();
  }
  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;

  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
        onTap: (int index) => setState(() => _selectedIndex = index),
        currentIndex: selectedIndex,
        selectedItemColor: Color.fromRGBO(255, 82, 42, 1.0),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.photo_library), title: Text('Галерея')),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text('Избранное')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_pin), title: Text('Профиль'))
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
    );
  }
}
