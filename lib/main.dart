import 'package:flutter/material.dart';
import 'package:gp/Modules/auth.dart';
import 'package:gp/screens/homescreen.dart';
import 'package:gp/screens/loadingscreen.dart';
import 'package:gp/screens/passResetScreen.dart';
import 'package:gp/screens/signUpScreen.dart';
import 'package:provider/provider.dart';
import './Modules/Usedcolors.dart';
import 'package:gp/screens/loginScreen.dart';



void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => Auth(),
      child: MyApp(),
    )

  );
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.redAccent
      ),
      debugShowCheckedModeBanner: false,
      title: 'Indoor navigator',
      initialRoute: '/',
      routes: {
        '/' : (context) => loadingsc(),
        loginSc.routename : (context) => loginSc(),
        passResetSc.routename : (context) => passResetSc(),
        signUpSc.routename : (context) => signUpSc(),
        homeSc.routename : (context) => homeSc(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: loadingsc(),
    );
  }
}
