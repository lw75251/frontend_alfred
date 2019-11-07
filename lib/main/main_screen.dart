import 'package:flutter/material.dart';
import 'package:flutter_alfred/custom/category.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Screen"),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader( child: Text('Profile'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile( title: Text('Item 1'),
              onTap: () { Navigator.pop(context); },
            ),
            ListTile( title: Text('Item 2'),
              onTap: () { Navigator.pop(context); },
            ),
          ],
        ),
      ),
      body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            CategoryTile(),
            CategoryTile(),
        ]),
    );
  }
}