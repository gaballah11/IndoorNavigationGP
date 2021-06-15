import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/Modules/userInfo.dart';
import 'package:gp/Modules/validation.dart';
import 'package:gp/Modules/auth.dart';
import 'package:gp/Widgets/Inputlabellog.dart';
import 'package:gp/Widgets/PasswordLabel.dart';
import 'package:gp/Widgets/Sign%20button.dart';
import 'package:gp/Widgets/SmallInputlabellog.dart';
import 'package:gp/Widgets/phonelabel.dart';
import 'package:gp/screens/homescreen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../Modules/Usedcolors.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class signUpSc extends StatefulWidget {
  static const routename = '/signup';

  @override
  _signUpScState createState() => _signUpScState();
}

class _signUpScState extends State<signUpSc> {
  User currUser=new User();

  String json;
  bool signed= false;

  final _formKey = GlobalKey<FormState>();
  TextEditingController stname = new TextEditingController(),
      lstname = new TextEditingController(),
      usernamecont = new TextEditingController(),
      emailcont = new TextEditingController(),
      stpass = new TextEditingController(),
      ndpass = new TextEditingController(),
      phonecont = new TextEditingController();
  bool hidden = true;

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
                    top: MediaQuery.of(context).size.height / 20),
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
                      top: MediaQuery.of(context).size.height / 5),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            smallTextlabelinput(
                                "First Name", TextInputType.text, stname),
                            SizedBox(
                              width: 15,
                            ),
                            smallTextlabelinput(
                                "Last Name", TextInputType.text, lstname),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Textlabelinput(
                            "Username", TextInputType.text, usernamecont, username: true),
                        SizedBox(
                          height: 15,
                        ),
                        Textlabelinput("Email Address",
                            TextInputType.emailAddress, emailcont),
                        SizedBox(
                          height: 15,
                        ),
                        //Passlabelinput("Password",stpass),
                        stpasslabel(),
                        SizedBox(
                          height: 15,
                        ),
                        //Passlabelinput("Re-enter Password", ndpass, ndpass: true, relativecontroller: stpass),
                        ndpasslabel(),
                        SizedBox(
                          height: 15,
                        ),
                        phoneinput("Phone number", phonecont),

                        SizedBox(
                          height: 30,
                        ),
                        signButton("Register", () {
                            registerbutton();
                        }),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "cancel",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: 'Montserrat',
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column stpasslabel() {
    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 5),
                              child: Text(
                                "Password",
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
                              child: TextFormField(
                                controller: stpass,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(left: 25, top: 15),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      hidden
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: backcolor,
                                    ),
                                    onPressed: togle,
                                  ),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                showCursor: true,
                                obscureText: hidden,
                                cursorColor: Colors.redAccent,
                                cursorRadius: Radius.circular(5),
                                cursorWidth: 3.5,
                                validator: (value) {
                                  return Validator.validatePasswordLength(
                                      value);
                                },
                              ),
                            ),
                          ),
                        ],
                      );
  }

  Column ndpasslabel() {
    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 5),
                              child: Text(
                                "Re-enter your Password",
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
                              child: TextFormField(
                                controller: ndpass,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.only(left: 25, top: 15),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      hidden
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: backcolor,
                                    ),
                                    onPressed: togle,
                                  ),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                showCursor: true,
                                obscureText: hidden,
                                cursorColor: Colors.redAccent,
                                cursorRadius: Radius.circular(5),
                                cursorWidth: 3.5,
                                validator: (value) {
                                  String prepass = stpass.text;
                                  return  Validator.validatendPassword(value, prepass);
                                },
                              ),
                            ),
                          ),
                        ],
                      );
  }

  void registerbutton() async {
    if (_formKey.currentState.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
      //currUser.username = usernamecont.text;
      String userpass =stpass.text;
      print("before signup");
      try{
        print("****trying to signup****");
        await Provider.of<Auth>(context, listen: false)
            .signup(firstname: stname.text, lastname: lstname.text, username: usernamecont.text, email: emailcont.text, password: userpass, phonenumber: '20'+phonecont.text )
            .then((value) => Navigator.of(context).pushReplacementNamed(homeSc.routename))
            .catchError( (err) {
              _showErrorDialog(err.toString());
            });
      }
      catch (err) {
        print(err);
      }
    }
  }

  void togle() {
    setState(() {
      hidden = !hidden;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        elevation: 50,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0))
        ),
        backgroundColor: backcolor,
        title: Text(
          'Error!',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        content: Text(
          message,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

}
