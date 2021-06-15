import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/Modules/Usedcolors.dart';
import 'package:gp/Modules/validation.dart';

class Passlabelinput extends StatefulWidget {

  String title;
  bool ndpass=false;
  TextEditingController incontroller;
  TextEditingController relativecontroller;
  Passlabelinput(this.title, this.incontroller,{this.relativecontroller,this.ndpass});
  @override
  _PasslabelinputState createState() => _PasslabelinputState(title, incontroller,relativecontroller:relativecontroller, ndpass: ndpass);
}

class _PasslabelinputState extends State<Passlabelinput> {
  String title;
  TextEditingController incontroller;
  TextEditingController relativecontroller;
  bool hidden = true;
  bool ndpass=false;
  _PasslabelinputState(this.title, this.incontroller,{this.relativecontroller,this.ndpass});
  void togle() {
    setState(() {
      hidden = !hidden;
    });
  }
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
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 25, top: 15),
                suffixIcon: IconButton(
                  icon: Icon(
                    hidden ? Icons.visibility_off : Icons.visibility,
                    color: backcolor,
                  ),
                  onPressed: togle,
                ) ,

              ),
              keyboardType: TextInputType.visiblePassword,
              showCursor: true,
              obscureText: hidden,
              cursorColor: Colors.redAccent,
              cursorRadius: Radius.circular(5),
              cursorWidth: 3.5,
              validator: (value){

                print(value);

                print(ndpass);
                String prepass = relativecontroller.text;
                print(prepass);
                return ndpass?  Validator.validatendPassword(value, prepass)
                :  Validator.validatePasswordLength(value);
              },

            ),
          ),
        ),
      ],
    );
  }
}



