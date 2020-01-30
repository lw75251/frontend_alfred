import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_alfred/models/MenuModels.dart';
import 'package:flutter_alfred/models/UserModel.dart';
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
  final String tableId = "test";
  final List<ItemSummary> _items = [];
  
  String toJson(User user) {
    List<dynamic> items = _items.map((itemSummary) => itemSummary.toJson()).toList();

    Map<String, dynamic> data = {
      "customerId": user.uid,
      "restaurantId": "123",
      "tableId": "Table 2",
      "items": items,
      "totalCost": subtotal,
      "tip": tip,
      "location": "150 Commons Way",
      "epochTime": "2919402024" 
    };

    return jsonEncode(data);
  }

  double _tip = 0;
  UnmodifiableListView<ItemSummary> get items => UnmodifiableListView(_items);

  int get quantity => _items.length == 0 ? 0 : _items.map((item) => item.quantity).reduce((cur, next) => cur + next);
  double get subtotal => _items.length == 0 ? 0 : _items.map((item) => item.price * item.quantity).reduce((cur, next) => cur + next);
  double get tax => _items.length == 0 ? 0 : subtotal * 0.035 + 0.15;
  double get tip => _tip * subtotal;
  
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

  void printOrder() {
    print("Order Summary");
    _items.forEach((item) => print("${item.name}: ${item.quantity}"));
  }

  /// Returns Response Code to show correct UI
  Future<int> sendOrderSummary(User user) async {
    Map<String, String> headers = {"Content-type": "application/json"};
    String basePath = "http://10.0.2.2:3000/order"; 

    var data = toJson(user);

    http.Response response = await http.post(basePath, headers: headers, body: data);
    return response.statusCode;
  }   

}