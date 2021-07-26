import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/Modules/accessPoint.dart';
import 'package:gp/Modules/place.dart';
import 'package:gp/Widgets/routePainter.dart';
import 'package:gp/screens/placesScreen.dart';
import 'package:location/location.dart';
import 'package:gp/Modules/Usedcolors.dart';
import 'package:gp/Modules/auth.dart';
import 'package:gp/Modules/userInfo.dart';
import 'package:gp/Widgets/searchBar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gp/screens/loginScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';
import 'package:gp/Modules/locator.dart';

class homeSc extends StatefulWidget {
  static const routename = '/home';

  const homeSc({Key key}) : super(key: key);

  @override
  _homeScState createState() => _homeScState();
}

class _homeScState extends State<homeSc> {
  bool navigating;
  bool detectingLocation;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  User signedUSer;
  bool isLocationOn;
  bool havedestination;
  Destination destination;
  Location location = new Location();
  locator myloc;
  coordinates userCoord;
  StreamSubscription sub;
  List<Place> availPlaces;
  List<coordinates> route;

  @override
  void initState() {
    // TODO: implement initState

    navigating = false;
    detectingLocation = false;

    destination = new Destination('', coordinates(0, 0), 0.0, havedest: false);
    availPlaces = [];
    myloc = new locator();
    userCoord = coordinates(0.0, 0.0);
    route = [];

    getuserdata().then((currUser) {
      setState(() {
        signedUSer = currUser;
      });
    });

    getLocationStatus();
    getAvailablePlaces();
    //openLocationSetting();
    super.initState();
  }

  getuserdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("pre user");
    final extractedData = jsonDecode(prefs.getString("userData"));
    print(extractedData);
    return new User(
      firstname: extractedData['fname'],
      lastname: extractedData['lname'],
      email: extractedData['email'],
      username: extractedData['username'],
      password: extractedData['password'],
      phonenumber: extractedData['phoneNumber'],
    );
  }

  void getAvailablePlaces() async {
    final apiUrl =
        'https://indoor-navigator.herokuapp.com/ComputerAI/lab7/places';
    Uri myUri = Uri.parse(apiUrl);
    try {
      final response = await http.get(myUri);
      print(response.body);
      final responseData = jsonDecode(response.body) as Map;
      for (String key in responseData.keys) {
        coordinates c = coordinates(responseData[key]['x'].toDouble(),
            responseData[key]['y'].toDouble());
        Place p = new Place(key, c);
        availPlaces.add(p);
      }
      //print(availPlaces);

    } catch (e) {
      print(e);
    }
  }

  getLocationStatus() async {
    bool serviceEnabled;

    serviceEnabled = await location.serviceEnabled();

    setState(() {
      isLocationOn = serviceEnabled;
    });

    print("locacion is : $isLocationOn");
  }

  @override
  Widget build(BuildContext homecontext) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: mydrawer(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          //Map photo
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 120,
            color: Colors.amber,
            margin: EdgeInsets.only(top: 120),
            child: PhotoView.customChild(
              child: Stack(
                fit: StackFit.loose,
                alignment: Alignment.topLeft,
                children: [
                  Image.asset("assets/images/lab7.png"),
                  detectingLocation
                      ? Stack(
                          children: [
                            /*Container(
                              margin: EdgeInsets.only(
                                left: ((userCoord.x / 950) *
                                    (MediaQuery.of(context).size.width - 55) - 12) < 0 ? 0 : (userCoord.x / 950) *
                                    (MediaQuery.of(context).size.width - 55) - 12 ,
                                top: ((userCoord.y / 1550) *
                                    (MediaQuery.of(context).size.height - 325) - 12) < 0 ? 0 : (userCoord.y / 1550) *
                                    (MediaQuery.of(context).size.height - 325) - 12,
                              ),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  //color: Colors.redAccent.withOpacity(0.7),
                                  gradient:
                                      RadialGradient(radius: 0.5, colors: [
                                    Colors.redAccent.withOpacity(0.7),
                                    Colors.redAccent.withOpacity(0),
                                  ])),
                            ),*/
                            // drawing route
                            navigating
                                ? Container(
                                    margin: EdgeInsets.only(left: 13, top: 12),
                                    child: CustomPaint(
                                      //size: Size(300,300),
                                      painter: RoutePainter(route),
                                    ),
                                  )
                                : SizedBox(),

                            //showing pins on map
                            !navigating
                                ? Stack(
                                    children: availPlaces
                                        .map((e) => Container(
                                              margin: EdgeInsets.only(
                                                  right: 30, bottom: 182),
                                              alignment: Alignment(
                                                  globalTolocalX(e.coord.x),
                                                  globalTolocalY(e.coord.y)),
                                              child: GestureDetector(
                                                child: Image.asset(
                                                  "assets/images/pin.png",
                                                  height: 30,
                                                  width: 30,
                                                ),
                                                onTap: () {
                                                  getroute(userCoord, e.name);
                                                  destination.name = e.name;
                                                  destination.coord = e.coord;
                                                  setState(() {
                                                    destination.havedest = true;
                                                  });
                                                },
                                              ),
                                            ))
                                        .toList(),
                                  )
                                : Container(
                                    margin:
                                        EdgeInsets.only(right: 30, bottom: 182),
                                    alignment: Alignment(
                                        globalTolocalX(destination.coord.x),
                                        globalTolocalY(destination.coord.y)),
                                    child: Image.asset(
                                      "assets/images/pin.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),

                            //user current location

                            StreamBuilder<coordinates>(
                                stream: locator().locstream,
                                initialData: coordinates(0.0, 0.0),
                                builder:
                                    (ctx, AsyncSnapshot<coordinates> snapshot) {
                                  
                                  if(snapshot.hasData)
                                    userCoord = new coordinates(snapshot.data.x, snapshot.data.y);
                                  /*if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }

                                   */
                                  if (snapshot.connectionState ==
                                          ConnectionState.active ||
                                      snapshot.connectionState ==
                                          ConnectionState.done) {
                                    return Stack(
                                      children: [
                                        /*Container(
                                          width: 50,
                                          height: 50,
                                          margin: EdgeInsets.only(
                                            left: ( snapshot.data.x / 950) *
                                                (MediaQuery.of(context).size.width - 78),
                                            top: (snapshot.data.y / 1550) *
                                                (MediaQuery.of(context).size.height - 370),
                                          ),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.redAccent.withOpacity(0.5)
                                          ),
                                        ),*/
                                        Container(
                                          /*margin: EdgeInsets.only(
                                  left: ( snapshot.data.x / 950) *
                                          (MediaQuery.of(context).size.width - 52),
                                  top: (snapshot.data.y / 1550) *
                                          (MediaQuery.of(context).size.height - 322),
                                ),
                                 */
                                          margin: EdgeInsets.only(
                                              right: 30, bottom: 182),
                                          alignment: snapshot.hasData ?
                                              Alignment(
                                                  globalTolocalX(snapshot.data.x),
                                                  globalTolocalY(snapshot.data.y))
                                          :Alignment(globalTolocalX(0.0), globalTolocalY(0.0)),
                                          child: Image.asset(
                                            "assets/images/usermark.png",
                                            width: 18,
                                            height: 18,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  return Container(
                                    /*margin: EdgeInsets.only(
                                  left: ( snapshot.data.x / 950) *
                                      (MediaQuery.of(context).size.width - 52),
                                  top: (snapshot.data.y / 1550) *
                                      (MediaQuery.of(context).size.height - 322),
                                ),
                                 */
                                    margin:
                                        EdgeInsets.only(right: 30, bottom: 182),
                                    alignment: //snapshot.hasData ?
                                        Alignment(
                                            globalTolocalX(snapshot.data.x),
                                            globalTolocalY(snapshot.data.y)),
                                    //:Alignment(globalTolocalX(0.0), globalTolocalY(0.0)),
                                    child: Image.asset(
                                      "assets/images/usermark.png",
                                      width: 18,
                                      height: 18,
                                    ),
                                  );
                                }),
                          ],
                        )
                      : SizedBox(),
                ],
              ),
              //enableRotation: true,
              maxScale: 2.0,
              initialScale: 1.1,
              minScale: 0.97,
              basePosition: Alignment.topLeft,

              backgroundDecoration: BoxDecoration(
                image: DecorationImage(
                    image: Image.asset("assets/images/floor.png").image,
                    fit: BoxFit.cover),
                color: Colors.white,
              ),
              //initialScale: 1.5,
              //basePosition: Alignment(0,1),
              tightMode: true,
            ),
          ),
          !detectingLocation
              ? Center(
                  child: Container(
                    width: 220,
                    height: 170,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      color: backcolor.withOpacity(0.8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.redAccent,
                          size: 60,
                        ),
                        Text(
                          "You are not detecting location!\nPress on the location button.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                )
              : SizedBox(),
          Stack(
            children: [
              //shadow on top of picture
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 6,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [backcolor, backcolor.withOpacity(0)])),
                ),
              ),
              //Drawer button
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 15,
                    horizontal: 25),
                child: Align(
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
              ),
              //Floating location and places buttons
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                          heroTag: "places button",
                          backgroundColor: backcolor,
                          child: Icon(
                            Icons.apps_rounded,
                            size: 30,
                          ),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    placesSc(availPlaces),
                              ),
                            ) as Place;
                            if (result != null) {
                              getroute(userCoord, result.name);
                              destination.name = result.name;
                              destination.coord = result.coord;
                              setState(() {
                                destination.havedest = true;
                              });
                            }
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      FloatingActionButton(
                          heroTag: "location button",
                          backgroundColor:
                              detectingLocation ? Colors.redAccent : backcolor,
                          child: Icon(
                            Icons.my_location_rounded,
                            size: 30,
                          ),
                          onPressed: () async {
                            PermissionStatus _permissionGranted;
                            try {
                              print("loc button");
                              if (!isLocationOn) {
                                isLocationOn = await location.requestService();
                                if (!isLocationOn) {
                                  return;
                                }
                              }
                              _permissionGranted =
                                  await location.hasPermission();
                              if (_permissionGranted ==
                                  PermissionStatus.denied) {
                                _permissionGranted =
                                    await location.requestPermission();
                                if (_permissionGranted !=
                                    PermissionStatus.granted) {
                                  return;
                                }
                              }
                            } catch (e) {
                              print("***********" + e.toString());
                            }

                            setState(() {
                              detectingLocation = !detectingLocation;
                            });
                          }),
                    ],
                  ),
                ),
              ),
              //Search bar
              Container(
                  margin: EdgeInsets.only(top: 25, left: 70),
                  child: searchbar(availPlaces, destination)),
              //bottom sheet
              destination.havedest
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(50)),
                        child: Container(
                          height: 200,
                          color: backcolor,
                          child: Stack(
                            fit: StackFit.expand,
                            alignment: Alignment.topLeft,
                            children: [
                              Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            destination.havedest = false;
                                            navigating = false;
                                          });
                                        }),
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: backcolor,
                                          backgroundImage: NetworkImage(
                                              'https://www.osiristours.com/wp-content/uploads/2018/03/Four-Seasons-Nile-Plaza-1-1024x720-1.jpg'),
                                          radius: 50,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              destination.name,
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "${destination.distance} m , 4.5 stars",
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 22,
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                navigating = true;
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Text(
                                                "Navigate",
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 22,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
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
                  buildlistTile(
                      "Logout",
                      Icon(Icons.logout, color: Colors.redAccent),
                      () => logout),
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

  void logout() async {
    try {
      print("****trying to logout****");
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      Navigator.of(context).pushReplacementNamed(loginSc.routename);
    } catch (err) {
      print(err);
    }
  }

  globalTolocalX(double x) {
    double newX = 0.0;
    x < 475 ? newX = -(1 - (x / 475)) : newX = (x - 475) / 475;
    return newX;
  }

  globalTolocalY(double y) {
    double newY = 0.0;
    y < 775 ? newY = -(1 - (y / 775)) : newY = (y - 775) / 775;
    return newY;
  }

  void getroute(coordinates currCoord, String destName) async {
    final apiSignUpUrl = 'https://indoor-navigator.herokuapp.com/route';
    Uri myUri = Uri.parse(apiSignUpUrl);
    try {
      print('http post');
      final response = await http.post(
        myUri,
        body: jsonEncode(
          <String, dynamic>{
            "curr_location_x": currCoord.x,
            "curr_location_y": currCoord.y,
            "destination": destName
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      final responseData = jsonDecode(response.body) as Map;
      route = [];
      for (List c in responseData["path"]) {
        route.add(coordinates(c[0].toDouble(), c[1].toDouble()));
      }

      setState(() {
        destination.distance =
            double.parse(responseData["distance"].toStringAsFixed(2));
      });
    } catch (err) {
      throw err;
    }
  }
}

class Destination {
  String name;
  coordinates coord;
  bool havedest;

  double distance;

  Destination(this.name, this.coord, this.distance, {this.havedest = false});
}
