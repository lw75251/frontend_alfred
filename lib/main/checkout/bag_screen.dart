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


  final List<String> ordered = [
    "Satay Chicken Skewers",
    "Steak",
    "Burrito"
  ];

      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: <Widget>[
      //     Text(ordered[0]),
      //     Text("\$4.75")
      //   ],
      // ) 

  Widget get _orderBlock => Container(
    color: Colors.white,
    child: ListView.separated(
      shrinkWrap: true,
      itemCount: ordered.length,
      itemBuilder: (ctx, int) {
        return Container(
          color: Colors.white,
          
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(ordered[int]),
              Text("\$4.75")
            ],
          ),
        );
      },
      separatorBuilder: (ctx, int) => const Divider()
    )
  );


  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () { Navigator.of(context).pop(true); },
      ),
      title: Text("Cart"),
    );

    return Scaffold(
      appBar: appBar,
      // body: ListView.separated(
      //     padding: const EdgeInsets.all(8),
      //     itemCount: items.length,
      //     itemBuilder: (BuildContext context, int index) {
      //       return items[index];
      //     },
      //     separatorBuilder: (BuildContext context, int index) => const Divider(),
      // ),
      body: _orderBlock,
      bottomNavigationBar: BottomAppBar(
        child: MaterialButton(child: Text("Pay"), onPressed: (){})

      ),
    );
  }
}