import 'dart:convert';
import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  // final bool guest;
  final String uid;
  final String brainTreeId;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  String _accessToken;

  User({
    // this.guest = false,
    this.uid,
    this.brainTreeId,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber
  });

  factory User.fromJson(Map<String, dynamic> json) {
    print(json);
    return User(
      // guest: false,
      uid: json["_id"],
      brainTreeId: json["brainTreeCustomerId"],
      firstName: json["firstName"],
      lastName: json["lastName"],      
      email: json["email"],
      phoneNumber: json["phoneNumber"],
    );
  }

  Map<String, dynamic> toJson() => 
  {
   "uid": uid,
   "brainTreeId": brainTreeId, 
   "firstName": firstName, 
   "lastName": lastName,
   "email": email,
   "phoneNumber": phoneNumber
  };

  Map<String, dynamic> toLoginJson(String password) => 
  {
    "email": email,
    "password": password
  };

  get accessToken => _accessToken;

}