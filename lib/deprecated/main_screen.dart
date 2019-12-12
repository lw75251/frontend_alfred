import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alfred/deprecated/home_pages/main_page.dart';

import 'package:flutter_alfred/routes/router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _selectedIndex = 0;

  final List pages = [
    // HomePage(key:PageStorageKey('Home')),
    // ProfilePage(),
    // MainPage(),
    // ProfilePage()
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
      padding: const EdgeInsets.only(left: 15.0, right: 3.0, top: 8.0),
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

    void qrOnTap() {
      var transition = (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
          return Stack(children: <Widget>[
              SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(0.0, 0.0),
                  end: const Offset(-1.0, 0.0),
                ).animate(animation),
                child: this.widget,
              ),
              SlideTransition(
                position: new Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              )
            ],
          );
        };

      router.navigateTo(context, qrRoute,
        transition: TransitionType.custom,
        // transitionBuilder: (context, animation, second, child) => SlideTransition(
        //   position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(animation),
          // child: child));
        transitionDuration: const Duration(milliseconds: 300),
        transitionBuilder: transition,
      );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: PageStorage(
      //   child: pages[_selectedIndex],
      //   bucket: bucket,
      // ),
      body: MainPage(),
      // bottomNavigationBar: BottomNavigationDotBar ( // Usar -> "BottomNavigationDotBar"
      //     items: <BottomNavigationDotBarItem>[
      //       BottomNavigationDotBarItem(icon: Icons.home, onTap: onTap(0)),
      //       BottomNavigationDotBarItem(icon: Icons.search, onTap: onTap(1)),
      //       BottomNavigationDotBarItem(icon: Icons.bookmark, onTap: onTap(2)),
      //       BottomNavigationDotBarItem(icon: Icons.person, onTap: onTap(3)),
      //     ]
      // ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: _buildIconButton(FontAwesomeIcons.user, Color(0xFFE0E0E0), 20.0, 50.0, (){}, 8),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Location"),
              InkWell(
                child: Icon(Icons.arrow_drop_down),
                onTap: (){},
              )
            ]
          ),
        ),
        actions: <Widget>[
          _buildIconButton(FontAwesomeIcons.gift, Color(0xFFE0E0E0), 16, 30, (){}, 8),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 10.0, top: 8.0),
            child: IconButton(
              icon: Icon(FontAwesomeIcons.qrcode), 
              iconSize: 20, 
              onPressed: qrOnTap
            ),
          )
        ],
      ),

    );
  }
}