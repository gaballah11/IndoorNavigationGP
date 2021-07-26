import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/Modules/Usedcolors.dart';
import 'package:gp/Modules/place.dart';
import 'package:gp/screens/homescreen.dart';
import 'dart:ffi';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class searchbar extends StatefulWidget {
  Destination destination;
  List<Place> availPlaces;
  searchbar(this.availPlaces , this.destination, {Key key, BuildContext ctx}) : super(key: key);

  @override
  _searchbarState createState() => _searchbarState(availPlaces,destination);
}

class _searchbarState extends State<searchbar> {
  Destination destination;
  List<Place> availPlaces = [];

  final recentSearch = [];

  String query = '';
  FloatingSearchBarController cont;
  _searchbarState(this.availPlaces,this.destination){
    this.cont = new FloatingSearchBarController();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      controller: cont,
      clearQueryOnClose: true,
      borderRadius: BorderRadius.circular(50),
      height: 55,
      hint: 'Where to?',
      openAxisAlignment: 0.0,
      width: MediaQuery.of(context).size.width / 1.4,
      axisAlignment: 0.0,
      scrollPadding: EdgeInsets.only(top: 16, bottom: 20),
      elevation: 4.0,
      physics: BouncingScrollPhysics(),
      onQueryChanged: (query) {
        setState(() {
          this.query = query;
        });
      },
      automaticallyImplyBackButton: false,
      automaticallyImplyDrawerHamburger: false,
      backdropColor: Colors.transparent,
      transitionCurve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 500),
      transition: CircularFloatingSearchBarTransition(),
      debounceDelay: Duration(milliseconds: 500),
      actions: [

        FloatingSearchBarAction.searchToClear(
          showIfClosed: true,
        ),
      ],
      builder: (ctx, transition) {
        return Builder(

          builder: (BuildContext searchctx) {
            return ClipRRect(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15), bottom: Radius.circular(55)),
              child: Container(
                color: backcolor,
                padding: EdgeInsets.all(10),
                child: query.isEmpty? Column(
                  children: [
                    Text(
                      'Your results will appear here.',
                      style: TextStyle(color: Colors.white,
                          fontSize: 18),
                    ),
                  ],
                )
                        : availPlaces.any((element) => element.name.startsWith(query)) ?
                            Column(
                  children: availPlaces.where((place) => place.name.startsWith(query)).map((place) => ListTile(
                    title: Text(
                      place.name,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      'Press on the place to navigate',
                      style: TextStyle(color: Colors.white.withOpacity(0.7)),
                    ),
                    trailing: CircleAvatar(
                      backgroundColor: Colors.white30,
                      backgroundImage: NetworkImage(
                          'https://freedesignfile.com/upload/2019/06/Royal-place-logo-vector.jpg'),
                      radius: 25,
                    ),
                    onTap: () {
                      print("*********");
                      cont.close();
                      setState(() {
                        destination.name = place.name;
                        destination.coord = place.coord;
                        destination.havedest=true;
                      });

                    },
                  ),).toList(),
                )
                              : Column(
                  children: [
                    Text(
                      'No results found!',
                      style: TextStyle(color: Colors.white,
                      fontSize: 18),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }



}
