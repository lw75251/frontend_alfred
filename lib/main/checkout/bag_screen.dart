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
      return Container(
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (ctx, int) => _orderItem(),
          separatorBuilder: (ctx, int) => Divider(color: Colors.white,),
        ),
      );
    } 
    
    return Scaffold(
      appBar: AppBar(
      )
      
    );
  }
}