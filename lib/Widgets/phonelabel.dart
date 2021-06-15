import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/main.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class phoneinput extends StatefulWidget {
  String title;
  TextEditingController phonecont;
  phoneinput(this.title, this.phonecont);

  @override
  _phoneinputState createState() => _phoneinputState(title, phonecont);
}

class _phoneinputState extends State<phoneinput> {
  String title;
  TextEditingController phonecont;
  _phoneinputState(this.title, this.phonecont);
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
            )),
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(3),
            child: IntlPhoneField(
              controller: phonecont,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 25),
              ),
              initialCountryCode: 'EG',
            ),
          ),
        ),
      ],
    );
  }
}
