import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_alfred/models/MenuModels.dart';

import 'package:http/http.dart' as http;

class Restaurant extends ChangeNotifier {
  final String restaurantId;
  final String tableId;

  Restaurant({
    this.restaurantId, 
    this.tableId,    
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      restaurantId: json["restaurantId"],
      tableId: json["tableId"]
    );
  }

  Future<List<Category>> getMenu() async {
    final String path = "http://10.0.2.2:3000/restaurant/" + restaurantId;
    final response = await http.get(path);
    List<dynamic> _jsonData = jsonDecode(response.body);

    List<Category> _menu = new List<Category>();

    _jsonData.forEach((object) {
      List<dynamic> itemData = object["items"];
      Category category = Category(
        title: object["category"],
        items: itemData.map<Item>( 
          (item) => Item.fromJson(item, object["category"])
        ).toList()
      );
      _menu.add(category);
    });

    return _menu;
  }

}