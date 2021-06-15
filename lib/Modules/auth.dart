import 'dart:convert';
import 'dart:async';

import 'package:gp/Modules/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  String _userId;


  bool get isAuth {
    return userId != null;
  }

  String get userId {
    if (_userId != null) {
      return _userId;
    }
    return null;
  }


  Future<void> _authenticate(
      String username, String password, String urlSegment) async {
    final apiSignUpUrl =
        'https://indoor-navigin.herokuapp.com/$urlSegment';
    Uri myUri = Uri.parse(apiSignUpUrl);
    try {
      print('http post');
      final response = await http.post(
        myUri,
        body: jsonEncode(<String,String>
          {
            "username": username,
            "password": password
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      if (response.statusCode != 202) {
        throw HttpException("Invalid Username or Password");
      }
      final responseData = jsonDecode(response.body) as Map;
      _userId = responseData["username"];
      print(_userId);
      print("hereeeee");
      notifyListeners();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("userData", response.body);

      print("prefssssss >>>" + "${prefs.getString("userData")}");
    } catch (err) {
      throw err;
    }
  }

  Future<void> _authsignup(String firstname, String lastname, String username,
      String email, String password, String phonenumber) async {
    final urlSegment = "register/";
    final apiSignUpUrl =
        'https://indoor-navigin.herokuapp.com/$urlSegment';
    Uri myUri = Uri.parse(apiSignUpUrl);
    try {
      var bodyy = jsonEncode(<String, String>
        {
          "fname": firstname,
          "lname": lastname,
          "username": username,
          "email": email,
          "password": password,
          "phoneNumber": phonenumber
        },
      );
      print(bodyy);

      final response = await http.post(
        myUri,
        body: bodyy,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print(response.body);
      String jsonsDataString = response.body.toString();
      var responseData = jsonDecode(jsonsDataString);
      print("*************************");
      print("${responseData}");
      if (responseData["status"]!="201") {
        if(responseData["email"]=="1" && responseData["username"]=="0"){
          throw HttpException("Email address already exist");
        }
        else if(responseData["email"]=="0" && responseData["username"]=="1"){
          throw HttpException("Username already exist");
        }
        else if(responseData["email"]=="1" && responseData["username"]=="1"){
          throw HttpException("Email and Username already exist");
        }
      }
      _userId = responseData["username"];
      notifyListeners();
      //** SAVE DATA ON THE DEVICE
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userData = jsonEncode(<String, String>
      {
        "fname": firstname,
        "lname": lastname,
        "username": username,
        "email": email,
        "password": password,
        "phoneNumber": phonenumber
      },
      );
      prefs.setString('userData', userData);
    } catch (err) {
      throw err;
    }
  }

  Future<void> signup({String firstname, String lastname, String username,
      String email, String password, String phonenumber})  async {
    try{
      await _authsignup(firstname, lastname, username, email, password, phonenumber);
    }catch(e){
      throw e;
    }
  }

  Future<void> login(String username, String password) async {
    const loginSeg = 'login/';
    try{
      await _authenticate(username, password, loginSeg);
    }catch(e){
      throw e;
    }
  }

  Future<bool> tryAutoLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }

    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;

    _userId = extractedUserData['username'];
    notifyListeners();
    return true;
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

}
