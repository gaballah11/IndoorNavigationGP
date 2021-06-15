import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/Modules/Usedcolors.dart';
import 'package:gp/Modules/auth.dart';
import 'package:gp/Modules/userInfo.dart';
import 'package:gp/Widgets/searchBar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gp/screens/loginScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class homeSc extends StatefulWidget {
  static const routename = '/home';



  const homeSc({Key key}) : super(key: key);

  @override
  _homeScState createState() => _homeScState();

}



class _homeScState extends State<homeSc>{
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  User  signedUSer;
  @override
  void initState(){
    // TODO: implement initState
    print("**********");
    getuserdata().then((currUser) {
      setState(() {
        signedUSer = currUser;
      });
    }
    );
    print("**********");
    super.initState();
  }


  getuserdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("pre user");
    final extractedData= jsonDecode(prefs.getString("userData"));
    print(extractedData);
    return new User(
      firstname : extractedData['fname'],
      lastname : extractedData['lname'],
      email : extractedData['email'],
      username : extractedData['username'],
      password : extractedData['password'],
      phonenumber : extractedData['phoneNumber'],
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: mydrawer(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
              child: SvgPicture.asset(
                "assets/images/2980959.svg",
                fit: BoxFit.cover,
              )
          ),


          Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/6,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        backcolor,
                        backcolor.withOpacity(0)
                      ]
                    )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 15,
                    horizontal: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: FloatingActionButton(
                          backgroundColor: backcolor,
                          child: Icon(
                            Icons.short_text_rounded,
                            size: 40,
                          ),
                          onPressed: () {
                            opendrawer(context);
                          }),
                    ),
                    SizedBox(
                      width: 15,
                    ),

                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                          backgroundColor: backcolor,
                          child: Icon(
                            Icons.apps_rounded,
                            size: 30,
                          ),
                          onPressed: () {}),
                      SizedBox(height: 10,),
                      FloatingActionButton(
                          backgroundColor: backcolor,
                          child: Icon(
                            Icons.my_location_rounded,
                            size: 30,
                          ),
                          onPressed: () {}),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 25,left: 70),
                  child: searchbar()
              ),
            ],
          ),
        ],
      ),
    );
  }



  Widget mydrawer() {
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(70)),
      child: Drawer(
        child: Expanded(
          child: Container(
              color: backcolor,
              child: Column(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      end: Alignment.bottomCenter,
                      begin: Alignment.topCenter,
                      colors: [
                        Colors.redAccent,
                        Colors.redAccent.withOpacity(0)
                      ],
                    )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: CircleAvatar(
                                backgroundColor: backcolor,
                                backgroundImage: NetworkImage(
                                    'https://indoor-navigin.herokuapp.com/static/profile_pics/default.jpg'),
                                radius: 25,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Text(
                                signedUSer.fullname,
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  buildlistTile(
                      "Detect My Location",
                      Icon(Icons.my_location_rounded, color: Colors.redAccent),
                      () {}),
                  Divider(),
                  buildlistTile("Places list",
                      Icon(Icons.apps_rounded, color: Colors.redAccent), () {}),
                  Divider(),
                  buildlistTile("Search for a place",
                      Icon(Icons.search, color: Colors.redAccent), () {}),
                  Divider(),
                  buildlistTile("Account setting",
                      Icon(Icons.settings, color: Colors.redAccent), () {}),
                  Divider(),
                  buildlistTile("Logout",
                      Icon(Icons.logout, color: Colors.redAccent), ()=>logout),


                ],
              )),
        ),
      ),
    );
  }

  ListTile buildlistTile(String title, Widget icon, Function funct) {
    return ListTile(
      leading: icon,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 18,
          color: Colors.white,
        ),
      ),
      onTap: funct(),
    );
  }

  void opendrawer(BuildContext context) {
    _scaffoldKey.currentState.openDrawer();
  }

  getImage() async {
    final urlSegment = "/display/default/";
    final apiSignUpUrl =
        'https://indoor-navigin.herokuapp.com/$urlSegment';
    Uri myUri = Uri.parse(apiSignUpUrl);
    try {
      print('http get');
      final response = await http.get(
          myUri);

      }catch(e){
        print(e);
      }
  }

  void logout() async {
    try{
      print("****trying to logout****");
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      Navigator.of(context).pushReplacementNamed(loginSc.routename);
    }
    catch (err) {
      print(err);
    }
  }




}
