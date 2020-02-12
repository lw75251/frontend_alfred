import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_alfred/models/MenuModels.dart';
import 'package:flutter_alfred/models/UserModel.dart';
import 'package:flutter_alfred/routes.dart';
import 'package:http/http.dart' as http;

class ItemSummary {
  final String name;
  final String category;
  final String image;
  final String description;
  final double price;
  
  int quantity;

  ItemSummary({
    this.name,
    this.category,
    this.image,
    this.description,
    this.price,
    this.quantity = 1
  });

  factory ItemSummary.fromJson(Map<String, dynamic> json) {
    return ItemSummary(
      name: json["name"],
      category: json["category"],
      image: json["image"],
      description: json["description"],
      price: json["price"]
    );
  }

  factory ItemSummary.fromItem(Item item, int quantity) {
    return ItemSummary(
      name: item.name,
      category: item.category,
      quantity: quantity,
      image: item.image,
      description: item.description,
      price: item.price,
    );
  }

  Map<String, dynamic> toJson() => 
  {
    "name": name,
    "category": category,
    "image": image,
    "price": price,
    "quantity": quantity
  };

  double get total => quantity * price;
  String get qname => quantity <= 1 ? name : name + " x$quantity";

  void incrementItem() {
    quantity++;
  }

  void decrementItem() {
    if ( quantity > 0 ) quantity--;
  }
}


class OrderSummary extends ChangeNotifier {
  final String state;
  final String tableId;
  final String userId;
  final String restaurantId;
  final List<ItemSummary> _items = [];

  final Map<String,double> taxes = {
    "AL": 0.04, "AK": 0, "AZ": 0.056, "AR": 0.065, "CA": 0.075,
    "CO": 0.029, "CT": 0.0635, "DE": 0, "FL": 0.06, "GA": 0.04,
    "HI": 0.04, "ID": 0.06, "IL": 0.0625, "IN": 0.07, "IA": 0.06,
    "KS": 0.065, "KY": 0.06, "LA": 0.04, "ME": 0.055, "MD": 0.06,
    "MA": 0.0625, "MI": 0.06, "MN": 0.0688, "MS": 0.07, "MO": 0.0423,
    "MT": 0, "NE": 0.055, "NV": 0.0685, "NH": 0, "NJ": 0.07,
    "NM": 0.0513, "NY": 0.04, "NC": 0.0475, "ND": 0.05, "OH": 0.0575,
    "OK": 0.045, "OR": 0, "PA": 0.06, "RI": 0.07, "SC": 0.06,
    "SD": 0.04, "TN": 0.07, "TX": 0.0625, "UT": 0.0595, "VT": 0.06,
    "VA": 0.053, "WA": 0.065, "WV": 0.06, "WI": 0.05, "WY": 0.04,
  };

  OrderSummary({
    this.userId,
    this.restaurantId,
    this.tableId,
    this.state,
  });


  String toJson(User user) {
    List<dynamic> items = _items.map((itemSummary) => itemSummary.toJson()).toList();

    Map<String, dynamic> data = {
      "customerId": user.uid,
      "restaurantId": "123",
      "tableId": "Table 2",
      "items": items,
      "totalCost": ordertotal,
      "tip": tip,
      "location": "150 Commons Way",
      "epochTime": "2919402024" 
    };

    return jsonEncode(data);
  }

  double _tip = 0;
  double _tax = 0;
  UnmodifiableListView<ItemSummary> get items => UnmodifiableListView(_items);

  int get quantity => _items.length == 0 ? 0 : _items.map((item) => item.quantity).reduce((cur, next) => cur + next);
  double get total => ordertotal + tax + tip + fee;
  double get ordertotal => _items.length == 0 ? 0 : _items.map((item) => item.price * item.quantity).reduce((cur, next) => cur + next);
  // double get tax => taxes[state] * ordertotal;
  double get tax => _tax;
  double get tip => _tip * ordertotal;
  double get fee => (ordertotal + tax + tip)* 0.029 + 0.30;
  
  double taxTest(String state) {
    _tax = taxes[state] * ordertotal;
    return _tax;
  }

  set tip(double percentage) {
    _tip = percentage;
    notifyListeners();
  }

  void addItem( ItemSummary item ) {
    _items.add(item);
    notifyListeners();
  }
  void removeItem(String name) {
    _items.removeWhere((item) => item.name == name);
  }
  void remove(ItemSummary item) {
    _items.remove(item);
  }


  /// Returns Response Code to show correct UI
  Future<int> sendOrderSummary(User user) async {
    Map<String, String> headers = {"Content-type": "application/json"};
    String basePath = productionPath + "/order"; 

    var data = toJson(user);
    http.Response response = await http.post(basePath, headers: headers, body: data);
    print(response.statusCode);
    return response.statusCode;
  }   

  void printOrder() {
    print("Order Summary");
    _items.forEach((item) => print("${item.name}: ${item.quantity}"));
  }
}