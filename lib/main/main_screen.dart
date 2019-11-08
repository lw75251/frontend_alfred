import 'package:flutter/material.dart';
import 'package:flutter_alfred/custom/category.dart';
import 'package:braintree_payment/braintree_payment.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);


  Widget _buildCategory(String text){
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      Text(text, style: TextStyle(fontSize: 30), textAlign: TextAlign.left,),
      Row(children: <Widget>[
        CategoryTile(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CategoryTile(),
        )
      ])
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Screen"),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader( child: Text('Profile'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile( title: Text('Item 1'),
              onTap: () { Navigator.pop(context); },
            ),
            ListTile( title: Text('Item 2'),
              onTap: () { Navigator.pop(context); },
            ),
          ],
        ),
      ),
      // body: GridView.count(
      //     primary: false,
      //     padding: const EdgeInsets.all(20),
      //     crossAxisSpacing: 10,
      //     mainAxisSpacing: 10,
      //     crossAxisCount: 2,
      //     children: <Widget>[
      //       CategoryTile(),
      //       CategoryTile(),
      //   ]),
      body: 
      Container(padding: const EdgeInsets.all(15),
        child: Column(children: <Widget>[
          _buildCategory("Menu"),
          _buildCategory("Deals")
        ])
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.credit_card),
        onPressed: () async {
          String clientNonce = " GET YOUR CLIENT NONCE FROM YOUR SERVER";

          BraintreePayment braintreePayment = new BraintreePayment();
          var data = await braintreePayment.showDropIn(
                  nonce: clientNonce, amount: "2.0", enableGooglePay: true);
          print("Response of the payment $data");

          // In case of success
          //{"status":"success","message":"Payment successful. Send the payment nonce to the server for the further processing.":"paymentNonce":"jdsfhedbyq772_34dfsf"}

          // In case of Failure
          //{"status":"fail","message":"User canceled the payment"}                  
        },
      ),

    );
  }
}