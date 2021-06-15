import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/Modules/Usedcolors.dart';
import 'dart:ffi';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class searchbar extends StatefulWidget {
  const searchbar({Key key}) : super(key: key);

  @override
  _searchbarState createState() => _searchbarState();
}

class _searchbarState extends State<searchbar> {
  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      borderRadius: BorderRadius.circular(50),
      height: 55,
      hint: 'Where to?',
      openAxisAlignment: 0.0,
      width: MediaQuery.of(context).size.width/1.4,
      axisAlignment: 0.0,
      scrollPadding: EdgeInsets.only(top: 16, bottom: 20),
      elevation: 4.0,
      physics: BouncingScrollPhysics(),
      onQueryChanged: (query) {
        //Your methods will be here
      },
      automaticallyImplyBackButton: false,
      automaticallyImplyDrawerHamburger: false,
      backdropColor: Colors.transparent,
      transitionCurve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 500),
      transition: CircularFloatingSearchBarTransition(),
      debounceDelay: Duration(milliseconds: 500),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: Icon(Icons.search_rounded),
            onPressed: () {
              print('Places Pressed');
            },
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15),bottom: Radius.circular(55)),
          child: Container(
            color: backcolor,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  title: Text('Home',style: TextStyle(color: Colors.white),),
                  subtitle: Text('more info here........',style: TextStyle(color: Colors.white.withOpacity(0.7)),),
                  trailing: CircleAvatar(
                    backgroundColor: Colors.white30,
                    backgroundImage: NetworkImage(
                        'https://freedesignfile.com/upload/2019/06/Royal-place-logo-vector.jpg'),
                    radius: 25,
                  ),
                ),
                ListTile(
                  title: Text('Home',style: TextStyle(color: Colors.white),),
                  subtitle: Text('more info here........',style: TextStyle(color: Colors.white.withOpacity(0.7)),),
                  trailing: CircleAvatar(
                    backgroundColor: Colors.white30,
                    backgroundImage: NetworkImage(
                        'https://freedesignfile.com/upload/2019/06/Royal-place-logo-vector.jpg'),
                    radius: 25,
                  ),
                ),
                ListTile(
                  title: Text('Home',style: TextStyle(color: Colors.white),),
                  subtitle: Text('more info here........',style: TextStyle(color: Colors.white.withOpacity(0.7)),),
                  trailing: CircleAvatar(
                    backgroundColor: Colors.white30,
                    backgroundImage: NetworkImage(
                        'https://freedesignfile.com/upload/2019/06/Royal-place-logo-vector.jpg'),
                    radius: 25,
                  ),
                ),
                ListTile(
                  title: Text('Home',style: TextStyle(color: Colors.white),),
                  subtitle: Text('more info here........',style: TextStyle(color: Colors.white.withOpacity(0.7)),),
                  trailing: CircleAvatar(
                    backgroundColor: Colors.white30,
                    backgroundImage: NetworkImage(
                        'https://freedesignfile.com/upload/2019/06/Royal-place-logo-vector.jpg'),
                    radius: 25,
                  ),
                  onTap: (){},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
