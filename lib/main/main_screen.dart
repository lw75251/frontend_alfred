import 'package:flutter/material.dart';
import 'package:flutter_alfred/custom/menu_item.dart';

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
    final alucard = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircleAvatar(
          radius: 72.0,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/images/alucard.jpg'),
        ),
      ),
    );

    final appBar = AppBar(
      leading: Icon(Icons.arrow_back),
      title: Text("Food"),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.check),
        )
      ],
    );

    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_basket),
        onPressed: (){},
      ),
      body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return items[index];
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
      )
      // body: ListView.builder(
      //   itemCount: items.length,
      //   itemBuilder: (context, index) => items[index],
      // ),
    );
  }
}