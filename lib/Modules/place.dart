import 'package:gp/Modules/accessPoint.dart';

class Place {
  String name;
  coordinates coord;
  bool havedest ;

  Place(this.name,this.coord,{this.havedest=false});
}