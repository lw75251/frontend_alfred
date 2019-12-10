import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CheckoutScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    Widget _orderItem() {
      return Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey)
                  ),
                  child: Center(child: Text("1")),
                ),
              ),
              Expanded(
                flex: 3,
                child:Text("Drunken Pig Sandwich", 
                  style: TextStyle(color: Colors.white)
                )
              ),
              Expanded(
                flex: 1,
                child: Text("\$13.00",
                  style: TextStyle(color: Colors.white)
                )
              )
          ]),
        ),
      );
    }
    
    Widget _orderSummary(){

      var textStyle = TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      );

      return Container(
        margin: const EdgeInsets.all(15.0),
        color: Colors.black,
        child: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              Text("Your Order",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text("Add items",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),              
            ])
          ),

          ListView.separated(
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (ctx, int) => _orderItem(),
            separatorBuilder: (ctx, int) => Divider(
              color: Colors.white,
              indent: 20.0,
              endIndent: 20.0,
            ),
          ),

          Divider(color: Colors.white),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
            child: Container(
              child: Column(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Text("Subtotal", style: textStyle),
                  Text("\$52.00", style: textStyle)
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Text("Promotion", style: textStyle),
                  Text("-\$5.00", style: textStyle)
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Text("Service Fee", style: textStyle),
                  Text("\$1.00", style: textStyle)
                ]),     
                Divider(color: Colors.white, indent: 5.0, endIndent: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Text("Tip", style: textStyle),
                  Text("\$1.00", style: textStyle)
                ]),       
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Text("Taxes", style: textStyle),
                  Text("\$3.00", style: textStyle)
                ]),       
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Text("Total", style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0
                  )),
                  Text("\$52.00", style: textStyle)
                ])                                        
              ]),
          )),

          Divider(color: Colors.white),
          Container(
            child: Text("Add a payment", style: textStyle,),
          )

        ])
      );
    } 
    
    // Widget _billSummary(){
    //   return 
    // }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: (){
            Navigator.pop(context, true);
          },
        ),
        title: Text("Cart",
          style: TextStyle(color: Colors.white),
        )
      ),
      body: Container(
        color: Colors.black,
        child: _orderSummary(),
      ),
      
    );
  }
}