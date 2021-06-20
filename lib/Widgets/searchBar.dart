import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/Modules/Usedcolors.dart';
import 'dart:ffi';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class searchbar extends StatefulWidget {
  const searchbar({Key key, BuildContext ctx}) : super(key: key);

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
      width: MediaQuery.of(context).size.width / 1.4,
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
      builder: (ctx, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(15), bottom: Radius.circular(55)),
          child: Container(
            color: backcolor,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    'Home',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'more info here........',
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
                    print(FloatingSearchAppBarState());
                    Navigator.of(ctx).popAndPushNamed('/home');
                    bottomsheet(ctx);
                  },
                ),
                ListTile(
                  title: Text(
                    'Home',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'more info here........',
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                  ),
                  trailing: CircleAvatar(
                    backgroundColor: Colors.white30,
                    backgroundImage: NetworkImage(
                        'https://freedesignfile.com/upload/2019/06/Royal-place-logo-vector.jpg'),
                    radius: 25,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Home',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'more info here........',
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                  ),
                  trailing: CircleAvatar(
                    backgroundColor: Colors.white30,
                    backgroundImage: NetworkImage(
                        'https://freedesignfile.com/upload/2019/06/Royal-place-logo-vector.jpg'),
                    radius: 25,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Home',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'more info here........',
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                  ),
                  trailing: CircleAvatar(
                    backgroundColor: Colors.white30,
                    backgroundImage: NetworkImage(
                        'https://freedesignfile.com/upload/2019/06/Royal-place-logo-vector.jpg'),
                    radius: 25,
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void bottomsheet(BuildContext ctx) {
    showModalBottomSheet(
      barrierColor: Colors.transparent,
        isDismissible: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(50))),
        context: context,
        builder: (BuildContext context) {
          return ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
            child: Container(
              height: 250,
              color: backcolor,
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.topLeft,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: IconButton(icon: Icon(Icons.close, color: Colors.white,size: 30,), onPressed: ()=>Navigator.of(context).pop()),
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: backcolor,
                              backgroundImage: NetworkImage(
                                  'https://www.osiristours.com/wp-content/uploads/2018/03/Four-Seasons-Nile-Plaza-1-1024x720-1.jpg'),
                              radius: 50,
                            ),
                            SizedBox(width: 20,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("StarBucks",style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 30,
                                  color: Colors.white,
                                ),),
                                SizedBox(height: 10,),
                                Text("25 mi , 4.5 stars", style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 22,
                                  color: Colors.white.withOpacity(0.5),
                                ),),
                                SizedBox(height: 20,),
                                Text("5 Mins away", style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 22,
                                  color: Colors.redAccent,
                                ),),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 20,),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: ElevatedButton(
                                onPressed: (){},
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text("Navigate", style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),),
                                )
                            )
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
