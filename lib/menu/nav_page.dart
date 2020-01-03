
import 'package:flutter/material.dart';
import 'package:flutter_alfred/checkout/bag_screen.dart';
import 'package:flutter_alfred/custom/fluid_nav_bar/fluid_nav_bar.dart';
import 'package:flutter_alfred/menu/menu_page.dart';

import 'package:flutter_alfred/models/OrderModels.dart';
import 'package:provider/provider.dart';

class MenuNavigation extends StatefulWidget {
  @override
  _MenuNavigationState createState() =>
      _MenuNavigationState();
}

class _MenuNavigationState
    extends State<MenuNavigation> {
  final List<Widget> pages = [
    MenuScreen(
      key: PageStorageKey('Menu'),
    ),
    CartScreen(
      key: PageStorageKey('Cart'),
    ),
    Text("Hi")
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrderSummary(),
      child: Scaffold(
        body: Stack(children: <Widget>[
          PageStorage(
            child: pages[_selectedIndex],
            bucket: bucket
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FluidNavBar(
              color: Color(0xFF21BFBD),
              onChange: (int) => setState(() => _selectedIndex = int),
            )
          )
        ])
      ),
    );
  }
}