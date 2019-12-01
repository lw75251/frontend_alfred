import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:flutter_alfred/custom/menu_item.dart';
import 'package:flutter_alfred/main/menu_page_content.dart';
import 'package:flutter_alfred/routes/router.dart';

class MenuPageHeader implements SliverPersistentHeaderDelegate {
  final double minExtent;
  final double maxExtent;
  
  MenuPageHeader({
    this.minExtent,
    @required this.maxExtent,
  });

  double textOpacity( double shrinkOffset ) {
    return 1.0 - 1.5*max(0.0, shrinkOffset) / maxExtent;
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.network("http://via.placeholder.com/325x250", fit: BoxFit.cover,),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black54],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated
            )
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 80, 
                width: 80,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Image.network("http://via.placeholder.com/80x80", fit: BoxFit.cover,),
              ),
              Text("Buffalo Wings", 
                style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.white.withOpacity(textOpacity(shrinkOffset)) 
                ),
              ),
              Text("101 E Front St (8.3 mi)",
                style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.white.withOpacity(textOpacity(shrinkOffset))
                ) 
              ),
          ]),
        )
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;
}

class MenuScreen extends StatelessWidget {
  static String tag = 'home-page';

  final List<MenuItem> items = [
    MenuItem("Satay Chicken Skewers", "assets/images/placeholder.jpeg", 20, 
      description: "Two pieces of finely crafted artisan chicken come with this deliciously long wooden stick",),
    MenuItem("Satay Chicken Skewers Really Long", "assets/images/placeholder.jpeg", 10),
    MenuItem("Satay Chicken Skewers", "assets/images/placeholder.jpeg", 10),
    MenuItem("Satay Chicken Skewers", "assets/images/placeholder.jpeg", 10),
    MenuItem("Satay Chicken Skewers", "assets/images/placeholder.jpeg", 10),
    ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: MenuPageHeader(
              minExtent: 125.0,
              maxExtent: 500.0
            ),
          ),

          // TODO: Page Content
          MenuPageContent()
        ],
      )
    );
  }
}