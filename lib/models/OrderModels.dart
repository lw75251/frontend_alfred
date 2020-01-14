import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_alfred/models/MenuModels.dart';

class ItemSummary {
  final String name;
  final String image;
  final String description;
  final double price;
  
  int quantity;

  ItemSummary({
    this.name,
    this.image,
    this.description,
    this.price,
    this.quantity = 1
  });

  factory ItemSummary.fromJson(Map<String, dynamic> json) {
    return ItemSummary(
      name: json["name"],
      image: json["image"],
      description: json["description"],
      price: json["price"]
    );
  }

  factory ItemSummary.fromItem(Item item, int quantity) {
    return ItemSummary(
      name: item.name,
      quantity: quantity,
      image: item.image,
      description: item.description,
      price: item.price,
    );
  }

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
}