
import 'package:flutter/material.dart';
import 'package:flutter_alfred/checkout/bag_screen.dart';
import 'package:flutter_alfred/custom/fluid_nav_bar/fluid_nav_bar.dart';
import 'package:flutter_alfred/menu/menu_page.dart';

import 'package:flutter_alfred/models/OrderModels.dart';
import 'package:flutter_alfred/models/PaymentModels.dart';
import 'package:flutter_alfred/models/RestaurantModel.dart';
import 'package:flutter_alfred/models/UserModel.dart';
import 'package:flutter_alfred/payment/payment_page.dart';
import 'package:flutter_alfred/routes.dart';
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

    final User user = arguments["user"];
    final Restaurant restaurant = arguments["restaurant"];
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: user),
        ChangeNotifierProvider.value(value: restaurant),
        ChangeNotifierProvider(create: (_) => OrderSummary(
          userId: user.uid,
          restaurantId: restaurant.restaurantId,
          state: restaurant.state
        )),
        ChangeNotifierProvider(create: (_) => BrainTreeClient(basePath: productionPath))
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