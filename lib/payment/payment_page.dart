import 'package:flutter/material.dart';
import 'package:flutter_alfred/models/OrderModels.dart';
import 'package:flutter_alfred/models/PaymentModels.dart';
import 'package:flutter_alfred/models/RestaurantModel.dart';
import 'package:flutter_alfred/models/UserModel.dart';

import 'package:flutter_alfred/payment/custom/NavigationButton.dart';
import 'package:flutter_alfred/payment/custom/OrderSummaryBlock.dart';
import 'package:braintree_payment/braintree_payment.dart';
import 'package:flutter_alfred/payment/custom/TipBlock.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatelessWidget {

  const PaymentPage({Key key}) : super (key: key);

  void _test(User user, OrderSummary orderSummary) {
    orderSummary.sendOrderSummary(user);
  }

  void _pay(User user, BrainTreeClient client, OrderSummary orderSummary) async {
    String clientNonce = await client.fetchClientToken(user);
    BraintreePayment braintreePayment = new BraintreePayment();

    try {
      var data = await braintreePayment.showDropIn(
        amount: orderSummary.total.toString(),
        nonce: clientNonce, enableGooglePay: true
      );
      if ( data["status"] == "success" ) {
        int postOrderStatus = await orderSummary.sendOrderSummary(user);
        if ( postOrderStatus == 201 ) {
          client.sendPaymentNonce(user, data, orderSummary.total);
        }
        // await orderSummary.sendOrderSummary(user);
      } else {
        throw new Exception("Nonce Failure");
      }
    } catch ( err ) {
      // TODO: Show Failure UI
    } 
  }

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);
    Restaurant restaurant = Provider.of<Restaurant>(context);
    BrainTreeClient client = Provider.of<BrainTreeClient>(context);
    OrderSummary orderSummary = Provider.of<OrderSummary>(context);

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
    return Scaffold(
        // backgroundColor: Color(0xFF7A9BEE),
        backgroundColor: Color(0xFFF5F5DC),
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
          title: Text('Checkout',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 18.0,
              color: Colors.white
            )
          ),
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
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(restaurant.name, 
                      style: headerstyle,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.timer),
                        Text("Ready in 20 minutes"),
                      ],
                    ),
                    Text(restaurant.address,
                      style: style,
                    ),
                  ],
                ),
              ),
              
              // NavigationButton(
              //   title: "Contact Information",
              //   description: "Leon Wu, (201) 602-9688",
              //   onTap: (){},
              // ),
              // Divider(color: Colors.grey),
              
              SizedBox(height: 16.0),
              // NavigationButton(
              //   title: "Payment Method",
              //   description: "Add a credit or debit card",
              //   onTap: (){},
              // ),
              // Divider(color: Colors.grey),

              OrderSummaryBlock(),

              TipBlock(),


              MaterialButton(
                onPressed: () => _pay(user, client, orderSummary),
                // onPressed: () => _test(user, orderSummary),
                child: Text("Pay"),
              )
            ],
          )
        )
    );
  }
}