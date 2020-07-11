import 'package:flutter/material.dart';

class MyDrawerItems {
  // @override
  // Widget build(BuildContext context) {

  //   return  ListTile(
  //             leading: Icon(Icons.home),
  //             title: Text("Home"),
  //             onTap: (){},
  //           );
  // }

  Widget drawerItem({IconData icon, String text, GestureTapCallback onTap}) {
    return SizedBox(
        height: 27,
        child: InkWell(
          child: Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 14.0),
                  child: Row(children: <Widget>[
                    Icon(
                      icon,
                      color: Colors.black54,
                      size: 22,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.0),
                      child: Text(text,
                          style: TextStyle(color: Colors.black54, fontSize: 14)
                              .copyWith(fontWeight: FontWeight.w800)),
                    ),
                  ]))
            ],
          ),
          onTap: onTap,
        ));
  }
}
