import 'package:flutter/material.dart';

class QuantityController extends StatefulWidget {
  QuantityController({Key key}) : super(key: key);

  @override
  _QuantityControllerState createState() => _QuantityControllerState();
}

class _QuantityControllerState extends State<QuantityController> {
  int _quantity = 0;

  void _incrementQuantity(){
    setState(() {
      ++_quantity;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 0) {
      setState(() {
        --_quantity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Text("Quantity"),
        Row( mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(icon: Icon(Icons.add_circle), onPressed: _incrementQuantity),
            Text("$_quantity"),
            IconButton(icon: Icon(Icons.remove_circle), onPressed: _decrementQuantity)
        ])
      ])
    );
  }
}