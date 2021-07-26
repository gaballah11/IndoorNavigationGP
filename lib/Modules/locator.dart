import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'accessPoint.dart';




class locator {

  //router with coordinates list
  coordinates userLocation= coordinates(0.0,0.0);
  List<AP> mywifis=[];
  List distances=[];
  //Map knownPositions={'tedata':coordinates(1134, 48), 'TE-Data':coordinates(743, 597), 'LINKDSL-Mustafa':coordinates(380, 45)};
  //Map knownAs={'tedata':-34, 'TE-Data':-37, 'LINKDSL-Mustafa':-34};
  Map knownAs={};
  Map knownPositions={};
  StreamSubscription sub;


  Stream<coordinates> get locstream async* {
    while(true){
      userLocation = coordinates(0.0, 0.0);
      await Future.delayed(Duration(milliseconds: 300), () async {
        print("inside stream");
        try{
          userLocation = await getuserlocation();
        }catch(e){
          Fluttertoast.showToast(
              msg: e.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.redAccent,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }

        //return userLocation;
      });
      yield userLocation;
    }

    /*
    await Stream.periodic(Duration(milliseconds: 300), (a){
      print("inside stream");
      userLocation = getuserlocation();
      print(a);
      return userLocation;
    });
    yield userLocation;
     */
  }

  locator() {
    print("inside construct");
    mywifis = [];
    distances = [];
    userLocation = null;

    //getAvailwifi();

    //getKnownAccessPoints();

  }

  getKnownAccessPoints() async {
    knownAs={};
    knownPositions={};
    final apiUrl =
        'https://indoor-navigator.herokuapp.com/ComputerAI/lab7/acesspoints';
    Uri myUri = Uri.parse(apiUrl);
    try{
      final response = await http.get(myUri);
      print(response.body);
      final responseData = jsonDecode(response.body) as Map;
      for( var key in responseData.keys){
        knownAs[key] = responseData[key]['A'];
        knownPositions[key] = coordinates(responseData[key]['x'].toDouble(),responseData[key]['y'].toDouble());
      }
      //print(knownAs);
      //print(knownPositions);
    }
    catch(e){
      print(e);
    }
  }

  getAvailwifi() async {
    //print("inside AvailWifis");
    List<AP> innermywifis = [];
    await getKnownAccessPoints();
    final networks = await loadWifiList();
    for(WifiNetwork network in networks){
      if(knownPositions.containsKey(network.ssid)){
        //print("inside cindition");
        AP ap = new AP(network,knownPositions[network.ssid],knownAs[network.ssid].toDouble());
        //print(ap.wifi.level);
        //print(ap.wifi.ssid);
        innermywifis.add(ap);
      }
    }
    return innermywifis;

  }

  Future<List<WifiNetwork>> loadWifiList() async {
    //print("inside load wifilist");
    List<WifiNetwork> htResultNetwork=[];
    try {
      htResultNetwork = await WiFiForIoTPlugin.loadWifiList();
    } on PlatformException {
      htResultNetwork = <WifiNetwork>[];
    }

    return htResultNetwork;
  }

  calculatedistance(AP ap){
    var power =  (ap.A-ap.wifi.level)/(10*ap.N);
    print("distance = ${pow(10, power)}");
    return pow(10, power) * 100;
  }


  getuserlocation() async{

    //getKnownAccessPoints();
    mywifis = await getAvailwifi();

    // if condition only for testing

    /*
    if(mywifis.isNotEmpty){
      mywifis = [];
      String s = '[{"SSID":"Florian","BSSID":"30:7e:cb:8c:48:e4","capabilities":"[WPA-PSK-CCMP+TKIP][ESS]","frequency":2400,"level":-23,"timestamp":201307720907},{"SSID":"Pi3-AP","BSSID":"b8:27:eb:b1:fa:e1","capabilities":"[WPA2-PSK-CCMP][ESS]","frequency":2480,"level":-60,"timestamp":201307720892},{"SSID":"AlternaDom-SonOff","BSSID":"b8:27:eb:98:b4:81","capabilities":"[WPA2-PSK-CCMP][ESS]","frequency":2800,"level":-80,"timestamp":201307720897}]';
      List<WifiNetwork> apwifi  = WifiNetwork.parse(s);
      AP ap1= AP(apwifi[0],coordinates(905, 1170),-34);
      mywifis.add(ap1);
      //apwifi.level = -44;
      ap1= AP(apwifi[1],coordinates(902, 416),-34);
      mywifis.add(ap1);
      //apwifi.level = -50;
      ap1= AP(apwifi[2],coordinates(353, 807),-37);
      mywifis.add(ap1);
    }
     */


    if(mywifis.isEmpty){
      print("mywifis empty");
    }
    try{
      distances=[];
      for(AP wifi in mywifis){
        var d = calculatedistance(wifi);
        distances.add(d);
      }
      print(distances);

      final a = pow(mywifis[0].position.x,2) + pow(mywifis[0].position.y,2) - pow(distances[0],2) ;
      //print(a);
      final b = pow(mywifis[1].position.x,2) + pow(mywifis[1].position.y,2) - pow(distances[1],2);
      //print(b);
      final c = pow(mywifis[2].position.x,2) + pow(mywifis[2].position.y,2) - pow(distances[2],2);
      //print(c);

      final x_cb = mywifis[2].position.x - mywifis[1].position.x; //print("xCb = $x_cb");
      final x_ac = mywifis[0].position.x - mywifis[2].position.x; //print("xAc = $x_ac");
      final x_ba = mywifis[1].position.x - mywifis[0].position.x; //print("xBa = $x_ba");
      final y_cb = mywifis[2].position.y - mywifis[1].position.y; //print("yCb = $y_cb");
      final y_ac = mywifis[0].position.y - mywifis[2].position.y; //print("yAc = $y_ac");
      final y_ba = mywifis[1].position.y - mywifis[0].position.y; //print("yBa = $y_ba");

      final xDenom = 2*(mywifis[0].position.x*y_cb + mywifis[1].position.x*y_ac + mywifis[2].position.x*y_ba);
      //print(xDenom);
      var xOfUser = ((a*y_cb + b*y_ac + c*y_ba)/xDenom).abs();

      final yDenom = 2*(mywifis[0].position.y*x_cb + mywifis[1].position.y*x_ac + mywifis[2].position.y*x_ba);
      //print(yDenom);
      var yOfUser = ((a*x_cb + b*x_ac + c*x_ba)/yDenom).abs();

      //xOfUser = 800;  yOfUser = 100;
      if(xOfUser >  950) xOfUser = 950;
      if(yOfUser > 1550) yOfUser = 1550;

      userLocation = coordinates(xOfUser, yOfUser);
      print("get user location : ($xOfUser,$yOfUser)");
      return coordinates(xOfUser, yOfUser);
    }catch(e){
      print(e);
      if(e.toString().startsWith("RangeError")){
        throw "must have 3 access points in range";
      }
    }

  }


}