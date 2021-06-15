import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/Modules/userInfo.dart';
import 'package:gp/Modules/validation.dart';
import 'package:gp/Widgets/PasswordLabel.dart';
import 'package:gp/Widgets/Sign%20button.dart';
import 'package:gp/screens/passResetScreen.dart';
import 'package:gp/screens/signUpScreen.dart';
import 'package:gp/screens/homescreen.dart';
import '../Widgets/Inputlabellog.dart';
import 'package:provider/provider.dart';
import 'package:gp/Modules/auth.dart';
import '../Modules/Usedcolors.dart';
import 'dart:convert';

class loginSc extends StatefulWidget {
  static const routename = '/login';

  @override
  _loginScState createState() => _loginScState();
}

class _loginScState extends State<loginSc> {
  bool signed = false;
  User currUser;

  String json;

  final _formKey = GlobalKey<FormState>();
  TextEditingController usernamecont = new TextEditingController();

  TextEditingController passwordcont = new TextEditingController();
  bool hidden = true;

  Function resetscreen(BuildContext ctx) {
    Navigator.pushNamed(ctx, passResetSc.routename);
  }

  Function signupscreen(BuildContext ctx) {
    print("navigating to signup");
    Navigator.pushNamed(ctx, signUpSc.routename);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: backcolor,
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Textlabelinput(
                          "Username",
                          TextInputType.text,
                          usernamecont,
                          username: true,
                        ),
                        SizedBox(height: 10),
                        stpasslabel(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Forgot your password?",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                resetscreen(context);
                              },
                              child: Text(
                                "Click here!",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 15),
                        signButton("Signin", () {
                          printcontrollers(context);
                        }),
                        SizedBox(height: 30),
                        signButton("Register", () {
                          signupscreen(context);
                        }),
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
            margin: EdgeInsets.symmetric(horizontal: 22, vertical: 5),
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
              controller: passwordcont,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 25, top: 15),
                suffixIcon: IconButton(
                  icon: Icon(
                    hidden ? Icons.visibility_off : Icons.visibility,
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
                return Validator.validatePasswordLength(value);
              },
            ),
          ),
        ),
      ],
    );
  }

  void printcontrollers(BuildContext ctx) async {
    if (_formKey.currentState.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text('Processing Data')));
      final usern = usernamecont.text;
      final pass = passwordcont.text;
      print("before login");
      try {
        print("****trying to login****");
        await Provider.of<Auth>(context, listen: false)
            .login(usern, pass)
            .then((_) =>
                Navigator.of(context).pushReplacementNamed(homeSc.routename))
            .catchError((err) {
          _showErrorDialog(err.toString());
        });
      } catch (err) {
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
