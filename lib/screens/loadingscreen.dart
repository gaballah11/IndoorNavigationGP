import 'package:location_permissions/location_permissions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/main.dart';
import '../Modules/Usedcolors.dart';
import 'package:gp/screens/loginScreen.dart';
import 'package:gp/Modules/auth.dart';
import 'package:gp/screens/homescreen.dart';
import 'package:provider/provider.dart';
import 'dart:async';


class loadingsc extends StatefulWidget {
  @override
  _loadingscState createState() => _loadingscState();
}

class _loadingscState extends State<loadingsc> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: backcolor,
        child: Column(
          children: [
            Stack(
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
                  margin: EdgeInsets.only(top:MediaQuery.of(context).size.height /8-30),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/Loading-02.png",
                        scale: 0.3,
                      ),
                      Container(
                        child: Text(
                          "Navigin",
                          style: TextStyle(
                            fontFamily: 'AldotheApache',
                            fontSize: 110,
                            color: Colors.redAccent,
                          ),
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
                //progress bar
                Container(
                  height: 10,
                  width: MediaQuery.of(context).size.width - 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  margin: EdgeInsets.only(left:40, top:MediaQuery.of(context).size.height-70),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                      backgroundColor: Colors.black.withOpacity(0.1),
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  startTime() async{
    var duration = new Duration(seconds: 5);
    bool isAuth = await Provider.of<Auth>(context, listen: false).tryAutoLogin();

    if(isAuth)
      return new Timer(duration, homescreen);
    return new Timer(duration, loginscreen);
  }

  homescreen() {
    Navigator.pushReplacementNamed(
      context,
      homeSc.routename,
    );
  }

  loginscreen() {
    Navigator.pushReplacementNamed(
      context,
        loginSc.routename,
    );
  }
}


