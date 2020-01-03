import 'package:flutter/material.dart';
import 'package:flutter_alfred/models/OrderModels.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


enum TabsDemoStyle { iconsAndText, iconsOnly, textOnly }

class _Category {
  final String title;
  final List<_Item> items;

   _Category({
    this.title,
    this.items
  });
}


class _Item {
  final String name;
  final String image;
  final String description;
  final double price;

  const _Item({
    this.name,
    this.image,
    this.description,
    this.price,
  });

  factory _Item.fromJson(Map<String, dynamic> json) {
    return _Item(
      name: json["name"],
      image: json["image"],
      description: json["description"],
      price: json["price"]
    );
  }

}


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

  // List<Widget> _buildCartItems(OrderSummary order) {
  //   List<ItemSummary> items = order.items;
  //   return items.map((ItemSummary item){
  //     return Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: <Widget>[
  //         Row(children: <Widget>[
  //           Image(
  //             image: AssetImage(item.image),
  //             fit: BoxFit.cover,
  //             height: 75.0,
  //             width: 75.0,
  //           ),      
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: <Widget>[
  //               Text(item.name, style: TextStyle(
  //                 color: Colors.black, fontSize: 16
  //               ),),
  //               SizedBox(height: 10.0,),
  //               Container(
  //                 height: 30,
  //                 width: 100,
  //                 decoration: BoxDecoration(
  //                   color: _color,
  //                   borderRadius: BorderRadius.circular(17.0)
  //                 ),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: <Widget>[
  //                     InkWell(
  //                       onTap: () => decrementItem(order, item),
  //                       child: Container(
  //                         height: 25.0,
  //                         width: 25.0,
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(7.0),
  //                           color: _color
  //                         ),
  //                         child: Center(
  //                           child: Icon(
  //                             Icons.remove,
  //                             color: Colors.white,
  //                             size: 16,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     Text("${item.quantity}",
  //                       style: TextStyle(
  //                           color: Colors.white,
  //                           fontFamily: 'Montserrat',
  //                           fontSize: 15.0)),
  //                     InkWell(
  //                       onTap: () => incrementItem(item),
  //                       child: Container(
  //                         height: 20.0,
  //                         width: 20.0,
  //                         decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(7.0),
  //                             color: Colors.white),
  //                         child: Center(
  //                           child: Icon(
  //                             Icons.add,
  //                             color: _color,
  //                             size: 16.0,
  //                           ),
  //                         ),
  //                       ),
  //                     )                                      
  //                   ],
  //                 ),
  //               ),              
  //             ],
  //           ),
  //         ]),
  //         Container(
  //           margin: const EdgeInsets.only(right: 10),
  //           child: Text(currencyFormat.format(item.price * item.quantity))
  //         )    
        
  //     ]);      
  //   }).toList();
  // }

  Widget _buildCartItem(OrderSummary order, ItemSummary item) {
    return Container(
      height: 100,
      width: 200,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            child: Image(
              image: AssetImage(item.image),
              fit: BoxFit.cover,
              height: 75.0,
              width: 75.0,
            )
          ),
          Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          item.name,
                          style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          currencyFormat.format(item.price),
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 15.0,
                            color: Colors.grey
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                      Container(
                        child: Text("Quantity: "),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: _color,
                          borderRadius: BorderRadius.circular(17.0)
                        ),
                        child: Row(children: <Widget>[
                          InkWell(
                            onTap: () => decrementItem(order, item),
                            child: Container(
                              height: 20.0,
                              width: 20.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: _color),
                              child: Center(
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: 16.0,
                                ),
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text("${item.quantity}",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 15.0)
                            ),
                          ),

                          InkWell(
                            onTap: () => incrementItem(item),
                            child: Container(
                              height: 20.0,
                              width: 20.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: Colors.white
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: _color,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),     
                        ]),
                      ),
                    ])              
                  ],
                ),
              ),
          ),
      ])
    );
  }

  // List<Widget> _buildCartItems(OrderSummary order) {
  //   List<ItemSummary> items = order.items;
  //   return items.map((ItemSummary item){
  //     return Container(
  //       color: Colors.grey,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: <Widget>[
  //           Row(children: <Widget>[
  //             Image(
  //               image: AssetImage(item.image),
  //               fit: BoxFit.cover,
  //               height: 75.0,
  //               width: 75.0,
  //             ),      
  //             Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 Column(children: <Widget>[
  //                   Text(item.name, style: TextStyle(
  //                     color: Colors.black, fontSize: 16
  //                   )),
  //                   Text(currencyFormat.format(item.price * item.quantity)), 
  //                 ])
  //               ]),
  //           ]),
              // Container(
              //   width: 35,
              //   height: 100,
              //   decoration: BoxDecoration(
              //     color: _color,
              //     borderRadius: BorderRadius.circular(17.0)
              //   ),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: <Widget>[
              //       InkWell(
              //         onTap: () => incrementItem(item),
              //         child: Container(
              //           height: 20.0,
              //           width: 20.0,
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(7.0),
              //               color: Colors.white),
              //           child: Center(
              //             child: Icon(
              //               Icons.add,
              //               color: _color,
              //               size: 16.0,
              //             ),
              //           ),
              //         ),
              //       ),

              //       Text("${item.quantity}",
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontFamily: 'Montserrat',
              //             fontSize: 15.0)
              //       ),

              //       InkWell(
              //         onTap: () => decrementItem(order, item),
              //         child: Container(
              //           height: 25.0,
              //           width: 25.0,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(7.0),
              //             color: _color
              //           ),
              //           child: Center(
              //             child: Icon(
              //               Icons.remove,
              //               color: Colors.white,
              //               size: 16,
              //             ),
              //           ),
              //         ),
              //       ),                                               
              //     ]),                
  //             ),
  //           ]),
  //     );  
  //   }).toList();
  // }


  @override
  Widget build(BuildContext context) {
    final orderSummary = Provider.of<OrderSummary>(context);
    return Scaffold(
        backgroundColor: _color,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
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
            children: <Widget>[
              Container(
                height: 46.0,
                color: Colors.transparent,
                child: Center(
                  child: Text("Total Items: ${orderSummary.quantity} | Total: ${currencyFormat.format(orderSummary.total)}", 
                    style: TextStyle(color: Colors.white, fontSize: 18)
                  )
                ),
              ),

              orderSummary.items.length == 0 ? 
              Expanded( child: Container(color: Colors.white,)) :
              Expanded(
                child: Container(
                  color: Color(0xFFCFCCD6),
                  // child: ListView(
                  //   shrinkWrap: true,
                  //   children: _buildCartItems(orderSummary),
                  // ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (ctx, int) => _buildCartItem(orderSummary, orderSummary.items[int]),
                    separatorBuilder: (ctx, int) => SizedBox(height: 10), itemCount: orderSummary.items.length,
                  ),
                ),
              ),

              Container(
                color: Color(0xFFCFCCD6),
                height: 56.0,
              )
            ],
          ),
        )
    );
  }
}  