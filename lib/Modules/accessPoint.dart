import 'package:flutter/cupertino.dart';
import 'package:wifi_iot/wifi_iot.dart';

class coordinates
{
  double x,y;

  coordinates(this.x,this.y) {
    if(x==null) x=0.0;
    if(y==null) y=0.0;
  }
}


class AP with ChangeNotifier {
  WifiNetwork wifi;
  coordinates position;
  double N, A;

  AP(this.wifi,this.position,this.A,{this.N=3});

}

