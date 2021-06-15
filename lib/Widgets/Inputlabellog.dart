import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/main.dart';
import 'package:gp/Modules/validation.dart';


class Textlabelinput extends StatelessWidget {

  String title;
  TextInputType keytype;
  TextEditingController incontroller;
  bool username ;
  Textlabelinput(this.title, this.keytype, this.incontroller, {this.username=false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 22, vertical: 5),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            )
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(3),

            child: TextFormField(
              controller: incontroller,
              validator: (value){
               return username? Validator.validateUserName(value) :
               ((keytype == TextInputType.text)? Validator.validateName(value) : Validator.validateEmail(value));
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 25),
              ),
              keyboardType: keytype,
              showCursor: true,
              cursorColor: Colors.redAccent,
              cursorRadius: Radius.circular(5),
              cursorWidth: 3.5,
              /*onChanged: (value){
                print(value);
                incontroller.text = value;
                print(incontroller.text);
              },*/
              /*onSaved: (String value) {
                incontroller.text = value;
                print(incontroller.text);
              },*/
            ),
          ),
        ),
      ],
    );
  }
}


