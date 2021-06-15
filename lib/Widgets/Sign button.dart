import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget signButton (String title, Function funct){
  return  ClipRRect(
    borderRadius: BorderRadius.circular(25),
    child: RaisedButton(
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.white,
        ),
      ),
      onPressed: (){funct();},
      color: Colors.redAccent,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
    ),
  );
}
