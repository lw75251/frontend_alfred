import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:braintree_payment/braintree_payment.dart';
import 'package:http/http.dart' as http;

class BrainTreeClient extends ChangeNotifier {
  final String basePath;

  String _clientToken;

  BraintreePayment braintreePayment;

  BrainTreeClient({
    this.basePath
  }) : assert (basePath != null);

  get clientToken => _clientToken;
  set clientToken(String token) {
    _clientToken = token;
    notifyListeners();
  }

  Future<String> fetchClientToken() async {
    final String path = basePath + "/client_token";
    final response = await http.get(path);

    if (response.statusCode == 200) {
      clientToken = response.body;
      return clientToken;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }  

  /// Returns Response Code to show correct UI
  Future<int> sendPaymentNonce(var data, double amount) async {
    Map<String, String> headers = {"Content-type": "application/json"};

    Map<String, dynamic> body = new Map<String, dynamic>.from(data);
    body["amount"] = amount;
    print("Printing $body");

    // print(body);
    http.Response response = await http.post(basePath, headers: headers, body: jsonEncode(body));

    print(response.body);
    // How to handle reponse code?
    return response.statusCode;
  }    

}