import 'dart:ui';
import 'dart:core';
import 'package:flutter/material.dart';
import 'dart:convert';

class User with ChangeNotifier {
  String firstname;
  String lastname;
  String username;
  String email;
  String password;
  String phonenumber;

  User({
    this.firstname,
    this.lastname,
    @required this.username,
    this.email,
    @required this.password,
    this.phonenumber,
  });

  void setpass(String pass){
    password = pass;
  }

  User.fromJson(Map<String, dynamic> json)
      : firstname = json['fname'],
        lastname = json['lname'],
        username = json['username'],
        email = json['email'],
        password = json['password'],
        phonenumber = json['phoneNumber'];

  void fetchdata(json)
  {
    firstname = json['fname'];
    lastname = json['lname'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    phonenumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() => {
    'fname': firstname,
    'lname': lastname,
    'username': username,
    'email': email,
    'password': password,
    'phoneNumber': phonenumber,
  };

  Map<String, dynamic> tologinJson() => {
    'username': username,
    'password': password,
  };

  String get fullname {
    return (firstname + " " + lastname) == null? " " : (firstname + " " + lastname);
  }

}