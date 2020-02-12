import 'package:flutter/material.dart';
import 'package:flutter_alfred/models/OrderModels.dart';
import 'package:flutter_alfred/models/RestaurantModel.dart';
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
    // final OrderSummary summary = Provider.of<OrderSummary>(context);
    final Restaurant restaurant = Provider.of<Restaurant>(context);

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
    return Consumer<OrderSummary>(
      builder: (context, summary, child) => 
      Container(
        padding: const EdgeInsets.all(10.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[                      
                        Text("Your Order",
                          style: headerstyle,
                        ),
                        Divider(color: Colors.grey),
                      ],
                    ) 
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: summary.items.length,
                    itemBuilder: (ctx, int) 
                      => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(summary.items[int].qname,
                            style: style,
                          ),
                          Text(currencyFormat.format(summary.items[int].total))
                        ],
                      ),
                  ),
                  SizedBox(height: 5.0,)
                ],
              ),
            ),
            Divider(color: Colors.grey),
            Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: Column(children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Order Subtotal", style: style,),
                    Text("${currencyFormat.format(summary.ordertotal)}", 
                      style: style,
                    )
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Tax",
                      style: style
                    ),
                    Text("${currencyFormat.format(summary.taxTest(restaurant.state))}",
                      style: style,
                    )
                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Processing Fee",
                      style: style
                    ),
                    Text("${currencyFormat.format(summary.fee)}",
                      style: style,
                    )
                  ],
                ),              
                SizedBox(height: 12.0),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Total", 
                      style: headerstyle,
                    ),
                    Text("${currencyFormat.format(summary.total)}",
                      style: headerstyle,
                    )
                  ],
                ),                            
              ]),
            )
          ],
        ),
      ),
    ); 
    
  }
}