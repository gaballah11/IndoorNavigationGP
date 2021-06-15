import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/Widgets/Inputlabellog.dart';
import 'package:gp/Widgets/Sign%20button.dart';
import '../Modules/Usedcolors.dart';

class passResetSc extends StatelessWidget {
  TextEditingController emailcont = TextEditingController();
  static const routename= '/reset';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        elevation: 0,
      ),
      backgroundColor: backcolor,
      body: Container(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              //background faded effect
              Image.asset(
                "assets/images/Sign in-02.png",
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
                color: Color.fromRGBO(255, 255, 255, 0.3),
              ),
              //decor image and titles
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 6),
                child: Column(
                  children: [
                    Text(
                      "Navigin",
                      style: TextStyle(
                        fontFamily: 'AldotheApache',
                        fontSize: 110,
                        color: Colors.redAccent,
                      ),
                    ),
                    Text(
                      "INDOOR NAVIGATION SYSTEM",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 2.9,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              // labels
              Container(
                //color: Colors.amber,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 2.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Textlabelinput(
                          "Enter your E-mail", TextInputType.emailAddress, emailcont),
                      SizedBox(height: 30,),
                      signButton("Reset your password", () {
                        Navigator.of(context).pop();
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
