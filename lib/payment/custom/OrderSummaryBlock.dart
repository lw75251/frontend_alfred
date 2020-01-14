import 'package:flutter/material.dart';
import 'package:flutter_alfred/models/OrderModels.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderSummaryBlock extends StatelessWidget {

  OrderSummaryBlock({Key key}) : super(key: key);

  final NumberFormat currencyFormat = NumberFormat.currency(
    // locale: "USD"
    symbol: "\$"
  ); 

  @override
  Widget build(BuildContext context) {
    final _summary = Provider.of<OrderSummary>(context); 
    TextStyle style = TextStyle(
      color: Colors.grey,
      fontFamily: 'Montserrat',
      fontSize: 16
    );
    TextStyle headerstyle = TextStyle(
      color: Colors.black,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.bold,      
      fontSize: 18
    );         
    return Container(
      padding: const EdgeInsets.all(10.0),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Your Order",
                  style: headerstyle,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (ctx, int) 
                    => Text(_summary.items[int].qname,
                      style: style,
                    ),
                  itemCount: _summary.items.length,
                )
              ],
            ),
          ),

          Divider(color: Colors.grey),

          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: Column(children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Subtotal", style: style,),
                  Text("${currencyFormat.format(_summary.subtotal)}", 
                    style: style,
                  )
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Tax",
                    style: style
                  ),
                  Text("${currencyFormat.format(_summary.subtotal)}",
                    style: style,
                  )
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Discounts",
                    style: style,
                  ),
                  Text("${currencyFormat.format(_summary.subtotal)}")
                ],
              ), 
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Total", 
                    style: headerstyle,
                  ),
                  Text("${currencyFormat.format(_summary.subtotal)}",
                    style: headerstyle,
                  )
                ],
              ),                            
            ]),
          )

        ],
      ),
    ); 
    
  }
}