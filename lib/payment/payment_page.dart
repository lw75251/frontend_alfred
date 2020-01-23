import 'package:flutter/material.dart';
import 'package:flutter_alfred/models/OrderModels.dart';
import 'package:flutter_alfred/models/PaymentModels.dart';
import 'package:flutter_alfred/models/UserModel.dart';

import 'package:flutter_alfred/payment/custom/NavigationButton.dart';
import 'package:flutter_alfred/payment/custom/OrderSummaryBlock.dart';
import 'package:braintree_payment/braintree_payment.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatelessWidget {

  const PaymentPage({Key key}) : super (key: key);

  void _pay(User user, BrainTreeClient client, OrderSummary orderSummary) async {
    // String clientNonce = user.guest ? 
    //   await client.guestFetchClientToken() : await client.userFetchClientToken(user);
    String clientNonce = await client.fetchClientToken(user);

    BraintreePayment braintreePayment = new BraintreePayment();

    try {
      var data = await braintreePayment.showDropIn(
        amount: orderSummary.subtotal.toString(),
        nonce: clientNonce, enableGooglePay: true
      );
      if ( data["status"] == "success" ) {
        user.guest ? 
          client.guestSendPaymentNonce(data, orderSummary.subtotal):
          client.userSendPaymentNonce(user, data, orderSummary.subtotal);
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
    BrainTreeClient client = Provider.of<BrainTreeClient>(context);
    OrderSummary orderSummary = Provider.of<OrderSummary>(context);
    return Scaffold(
        backgroundColor: Color(0xFF7A9BEE),
        // backgroundColor: Colors.white,
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
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Dine In at"),
                    Text("Bridgewater"),
                    Text("610 Commons Way, Bridgewater, NJ 08807")
                  ],
                ),
              ),
              
              NavigationButton(
                title: "Contact Information",
                description: "Leon Wu, (201) 602-9688",
                onTap: (){},
              ),
              Divider(color: Colors.grey),
              NavigationButton(
                title: "Payment Method",
                description: "Add a credit or debit card",
                onTap: (){},
              ),
              Divider(color: Colors.grey),
              OrderSummaryBlock(),
              Divider(),
              MaterialButton(
                onPressed: () => _pay(user, client, orderSummary),
                child: Text("Pay"),
              )
            ],
          )
        )
    );
  }
}