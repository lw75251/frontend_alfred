import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_alfred/main/menu/custom/quantity_tracker.dart';

import 'package:intl/intl.dart';

class MenuItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final double price;

  final double _height = 160;

  const MenuItem(
    this.title,
    this.imageUrl,
    this.price,
    { this.description,
      Key key
    }
  ) : super(key: key);

  Widget _buildMenuInfo( String title, String description, double price ) {
    final NumberFormat _moneyFormat = new NumberFormat.currency(locale: 'en_US', symbol: "\$");
    TextStyle titleStyle = TextStyle(
      color: Colors.black,
      fontSize: 20
    );
    return Expanded( flex: 2, child: 
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(children: <Widget>[
          Text(title, style: titleStyle,),
          description != null ? Text(description) : Container(),
          Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(_moneyFormat.format(price)),
              QuantityController()
            ])
        ]),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container( height: _height,
      child: Row(children: <Widget>[
        Expanded( flex: 1, child: Image.asset(imageUrl)),
        _buildMenuInfo(this.title, this.description, this.price)
      ]),
    );
  }
}