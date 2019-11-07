import 'package:flutter/material.dart';
import 'package:flutter_alfred/custom/menu_item.dart';

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen({Key key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  final List<MenuItem> items = [
    MenuItem("Satay Chicken Skewers", "assets/images/placeholder.jpeg", 20, 
      description: "Two pieces of finely crafted artisan chicken come with this deliciously long wooden stick",),
    MenuItem("Satay Chicken Skewers Really Long", "assets/images/placeholder.jpeg", 10),
    ];


  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () { Navigator.of(context).pop(true); },
      ),
      title: Text("Checkout"),
      // actions: <Widget>[
      //   Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Icon(Icons.check),
      //   )
      // ],
    );

    return Scaffold(
      appBar: appBar,
      body: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return items[index];
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
      bottomNavigationBar: BottomAppBar(
        child: MaterialButton(child: Text("Checkout"), onPressed: (){})

      ),
    );
  }
}