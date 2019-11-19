import 'package:flutter/material.dart';
import 'package:flutter_alfred/custom/dot_bottom_nav.dart';
import 'package:flutter_alfred/main/home_pages/home_page.dart';
import 'package:flutter_alfred/main/home_pages/profile_page.dart';

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
    ProfilePage(),
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
    );
  }
}