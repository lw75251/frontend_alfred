import 'package:flutter/material.dart';
import 'package:flutter_alfred/custom/dot_bottom_nav.dart';
import 'package:flutter_alfred/main/home_pages/home_page.dart';
import 'package:flutter_alfred/main/home_pages/main_page.dart';
import 'package:flutter_alfred/main/home_pages/profile_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _selectedIndex = 0;

  final List pages = [
    HomePage(key:PageStorageKey('Home')),
    ProfilePage(),
    MainPage(),
    ProfilePage()
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  // Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
  //       onTap: (int index) => setState(() => _selectedIndex = index),
  //       currentIndex: selectedIndex,
  //       items: const <BottomNavigationBarItem>[
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.add), title: Text('First Page')),
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.list), title: Text('Second Page')),
  //       ],
  //     );

  Function onTap(int index) {
    return () => setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildIconButton(IconData iconData, Color buttonColor, 
    double iconSize, double circleSize, Function onPressed, double padding) {
    
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 5.0, top: 8.0),
      child: Container(
        height: circleSize, width: circleSize,
        color: Colors.white,
        child: RawMaterialButton(
          onPressed: onPressed,
          shape: CircleBorder(),
          fillColor: buttonColor ?? Colors.transparent,          
          child: Center(
            child: Icon(
              iconData,
              color: Colors.black,
              size: iconSize,
            ),
          )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
      bottomNavigationBar: BottomNavigationDotBar ( // Usar -> "BottomNavigationDotBar"
          items: <BottomNavigationDotBarItem>[
            BottomNavigationDotBarItem(icon: Icons.home, onTap: onTap(0)),
            BottomNavigationDotBarItem(icon: Icons.search, onTap: onTap(1)),
            BottomNavigationDotBarItem(icon: Icons.bookmark, onTap: onTap(2)),
            BottomNavigationDotBarItem(icon: Icons.person, onTap: onTap(3)),
          ]
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: _buildIconButton(FontAwesomeIcons.user, Colors.grey, 20.0, 50.0, (){}, 8),
        title: Center(
          child: Column(children: <Widget>[
            Text("Location")
          ]),
        ),
        actions: <Widget>[
          _buildIconButton(FontAwesomeIcons.gift, Colors.grey, 16, 30, (){}, 8),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 10.0, top: 8.0),
            child: IconButton(
              icon: Icon(FontAwesomeIcons.qrcode), 
              iconSize: 20, 
              onPressed: (){}
            ),
          )
        ],
      ),

    );
  }
}