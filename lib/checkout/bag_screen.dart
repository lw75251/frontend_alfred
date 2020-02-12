import 'package:flutter/material.dart';
import 'package:flutter_alfred/models/OrderModels.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {

  const CartScreen({Key key}) : super (key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {

  Color _color = Color(0xFFDE6B48);
  var selectedCard = 'WEIGHT';
  NumberFormat currencyFormat = NumberFormat.currency(
    // locale: "USD"
    symbol: "\$"
  ); 

  void incrementItem(ItemSummary item) {
    setState(() {
      item.incrementItem();
    });
  }

  void decrementItem(OrderSummary order, ItemSummary item) {
    item.decrementItem();
    if (item.quantity == 0) order.remove(item);
    order.printOrder();
    setState(() {});
  }  

  Widget _buildCartItem(OrderSummary order, ItemSummary item) {
    return Container(
      height: 75,
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      decoration: BoxDecoration(
        color: Color(0xffeca893),
        borderRadius: BorderRadius.circular(17.0)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(17.0)
            ),
            child: SizedBox(
                child: Image(
                  image: NetworkImage("https://alfredexpresstest.s3.amazonaws.com/food_images/${item.image}"),
                ),
                height: 75.0,
                width: 75.0,
              ),       
          ),
          Expanded(
            flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        Text(
                          item.qname,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        Text(
                          currencyFormat.format(item.total),
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 15.0,
                            color: Colors.white
                          ),
                        )                        
                      ]),
                    ),

                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () => incrementItem(item),
                            child: Container(
                              height: 20.0,
                              width: 20.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  // color: _color
                                  color: Colors.transparent
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.keyboard_arrow_up,
                                  color: Colors.white,
                                  size: 16.0,
                                ),
                              ),
                            ),
                          ),       
                          Text("${item.quantity}",
                            style: TextStyle(color: Colors.white),
                          ),
                          InkWell(
                            onTap: () => decrementItem(order, item),
                            child: Container(
                              height: 20.0,
                              width: 20.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                // color: Colors.white
                                color: Colors.transparent
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ])
              ),
          ),
      ])
    );
  }

  String quantityToItems(int quantity) => quantity > 1 ? "items" : "item";

  @override
  Widget build(BuildContext context) {
    final orderSummary = Provider.of<OrderSummary>(context);
    return Scaffold(
        backgroundColor: Color(0xffe48568),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          backgroundColor: _color,
          elevation: 0.0,
          title: Text('My Order',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 22.0,
                  color: Colors.white)),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: () {},
              color: Colors.white,
            )
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(height: 10, color: Color(0xffe48568)),

              orderSummary.items.length == 0 ? 
              Expanded( child: Container()) :
              Expanded(
                child: Container(
                  color: Color(0xffe48568),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (ctx, int) => _buildCartItem(orderSummary, orderSummary.items[int]),
                    separatorBuilder: (ctx, int) => SizedBox(height: 15), itemCount: orderSummary.items.length,
                  ),
                  // child: ListView.separated(
                  //   shrinkWrap: true,
                  //   itemBuilder: (ctx, int) => CartItemCard(itemData: orderSummary.items[int]),
                  //   separatorBuilder: (ctx, int) => SizedBox(height: 15), itemCount: orderSummary.items.length,
                  // ),                  
                ),
              ),

              // Container(
              //   margin: const EdgeInsets.all(15.0),
              //   child: Column(
              //     children: <Widget>[
              //       Container(
              //         decoration: BoxDecoration(
              //           color: Color(0xffeca893),
              //           borderRadius: BorderRadius.circular(17.0)
              //         ),                      
              //         padding: const EdgeInsets.all(20.0),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: <Widget>[
              //             Text("${orderSummary.quantity} " + quantityToItems(orderSummary.quantity),
              //               style: TextStyle(
              //                   fontFamily: 'Montserrat',
              //                   fontSize: 22.0,
              //                   color: Colors.white)),                        
              //             Text("Subtotal: " + currencyFormat.format(orderSummary.subtotal),
              //               style: TextStyle(
              //                   fontFamily: 'Montserrat',
              //                   fontSize: 22.0,
              //                   color: Colors.white)),                        
              //           ],
              //         ),
              //       ),
              //       // SizedBox(height: 20.0),
              //     ],
              //   ),
              // ),

              Container(
                color: Color(0xffe48568),
                height: 56.0,
              )              
            ],
          ),
        )
    );
  }
}  