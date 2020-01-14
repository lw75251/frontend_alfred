import 'package:flutter/material.dart';
import 'package:flutter_alfred/models/OrderModels.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartItemCard extends StatefulWidget {
  static double nominalHeightOpen = 145;
  static double nominalHeightClosed = 75;

  final ItemSummary itemData;
  final Color color;
  final VoidCallback onTap;
  


  CartItemCard({
    this.itemData,
    this.color = const Color(0xffeca893),
    this.onTap,
    Key key
  }) : super(key: key);

  @override
  _CartItemCardState createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> with TickerProviderStateMixin {
  bool isOpen = false;
  NumberFormat currencyFormat = NumberFormat.currency(
    // locale: "USD"
    symbol: "\$"
  ); 

  @override
  void initState() {
    super.initState();
  }

  void _handleTap() {
    setState(() {
      isOpen = !isOpen;
    });
  }

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

  Widget _buildTopContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(17.0)
          ),            
          child: Image(
            image: AssetImage(widget.itemData.image),
            // fit: BoxFit.cover,
            height: 75.0,
            width: 75.0,
          )
        ),
        Expanded(
          flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  widget.itemData.quantity == 1 ? 
                  Text(
                    widget.itemData.name,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ) : 
                  Text(
                    widget.itemData.name  + " x${widget.itemData.quantity}",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                  Text(
                    "${currencyFormat.format(widget.itemData.total)}",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
              ])
            ),
        ),
    ]
    );
  }

  Widget _buildBottomContent() {
    return Container(
      color: widget.color,
      child: Column(children: <Widget>[
        Divider(color: Colors.white,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
          GestureDetector(
            child: Text("Edit"),
          ),
          Container(
            color: Colors.white,
            width: 5.0,
            height: 15.0,
          ),
          _buildQuantityButtons()
        ]),

      ],
      )
    );
  }

  Widget _buildQuantityButtons() {
    final OrderSummary order = Provider.of<OrderSummary>(context);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(17.0)
          ),
          child: Row(children: <Widget>[
            InkWell(
              onTap: () => decrementItem(order, widget.itemData),
              child: Container(
                height: 20.0,
                width: 20.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    color: widget.color),
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
              child: Text("${widget.itemData.quantity}",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                  fontSize: 15.0)
              ),
            ),

            InkWell(
              onTap: () => incrementItem(widget.itemData),
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
                    color: widget.color,
                    size: 16,
                  ),
                ),
              ),
            ),     
          ]),
        ),
      ])     ,
    );
  }

  @override
  Widget build(BuildContext context) {
    double cardHeight = isOpen ? CartItemCard.nominalHeightOpen : CartItemCard.nominalHeightClosed;
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(horizontal: 30.0),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(17.0)
        ),
        curve: !isOpen ? ElasticOutCurve(0.9) : Curves.elasticOut,
        duration: Duration(milliseconds: !isOpen ? 1200 : 1500),
        height: cardHeight,
        child: Container(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                _buildTopContent(),
                AnimatedOpacity(
                  duration: Duration(milliseconds: !isOpen ? 1000 : 500),
                  curve: Curves.easeOut,
                  opacity: isOpen ? 1 : 0,
                  child: _buildBottomContent(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}