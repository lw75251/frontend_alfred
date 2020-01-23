import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class User extends ChangeNotifier {
  final bool guest;
  final String uid;
  final String brainTreeId;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  User({
    this.guest = false,
    this.uid,
    this.brainTreeId,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      guest: false,
      uid: json["uid"],
      brainTreeId: json["brainTreeId"],
      firstName: json["firstName"],
      lastName: json["lastName"],      
      email: json["email"],
      phoneNumber: json["phoneNumber"],
    );
  }
}