import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/Modules/validation.dart';
import 'package:gp/main.dart';

class smallTextlabelinput extends StatelessWidget {

  String title;
  TextInputType keytype;
  TextEditingController incontroller;

  smallTextlabelinput(this.title, this.keytype, this.incontroller);

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
        Container(
          width: MediaQuery.of(context).size.width/2.6,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(3),
              child: TextFormField(
                controller: incontroller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 25),
                ),
                keyboardType: keytype,
                showCursor: true,
                cursorColor: Colors.redAccent,
                cursorRadius: Radius.circular(5),
                cursorWidth: 3.5,
                validator: (value){
                  return Validator.validateName(value) ;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
