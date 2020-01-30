
import 'package:flutter/material.dart';
import 'package:flutter_alfred/checkout/bag_screen.dart';
import 'package:flutter_alfred/custom/fluid_nav_bar/fluid_nav_bar.dart';
import 'package:flutter_alfred/menu/menu_page.dart';

import 'package:flutter_alfred/models/OrderModels.dart';
import 'package:flutter_alfred/models/PaymentModels.dart';
import 'package:flutter_alfred/models/RestaurantModel.dart';
import 'package:flutter_alfred/models/UserModel.dart';
import 'package:flutter_alfred/payment/payment_page.dart';
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
      key: PageStorageKey("Menu"),
    ),
    CartScreen(
      key: PageStorageKey("Cart"),
    ),
    PaymentPage(
      key: PageStorageKey("Payment")
    ),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = ModalRoute.of(context).settings.arguments;

    final User user = arguments["user"] ?? User(
      brainTreeId: "guest",
      firstName: "Guest",
      lastName: "User",
    );
    final Restaurant restaurant = arguments["restaurant"] ?? Restaurant(
      restaurantId: "5e29f3481c9d440000be868f",
      tableId: "Table 1"
    );

    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: user),
        ChangeNotifierProvider.value(value: restaurant),
        ChangeNotifierProvider(create: (_) => OrderSummary()),
        ChangeNotifierProvider(create: (_) => BrainTreeClient(basePath: "http://10.0.2.2:3000/payment"))
      ],
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