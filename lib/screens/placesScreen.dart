import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/Modules/Usedcolors.dart';
import 'package:gp/Modules/place.dart';

class placesSc extends StatefulWidget {
  //static const routename = '/places';
  List<Place> availPlaces;

  placesSc(this.availPlaces, {Key key}) : super(key: key);

  @override
  _placesScState createState() => _placesScState(availPlaces);
}

class _placesScState extends State<placesSc> {
  List<Place> availPlaces;

  _placesScState(this.availPlaces);

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context).settings.arguments as List<Place>;
    //availPlaces = args;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Available Places",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 25,
            letterSpacing: 2.9,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromRGBO(0, 0, 0, 0),
        elevation: 0,
      ),
      backgroundColor: backcolor,
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        padding: EdgeInsets.all(15),
        mainAxisSpacing: 10,
        children: availPlaces
            .map((place) => ClipRRect(
          borderRadius: BorderRadius.circular(45),
          child: GestureDetector(
            onTap: (){
              place.havedest = true;
              Navigator.pop(context, place);
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              color: Color(0xff353a50),
              child: Stack(
                children: [
                  Image(image: NetworkImage(
                      'https://www.osiristours.com/wp-content/uploads/2018/03/Four-Seasons-Nile-Plaza-1-1024x720-1.jpg')),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 18),
                      child: Text(
                        place.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Montserrat',
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ))
            .toList(),
      ),
    );
  }
}
