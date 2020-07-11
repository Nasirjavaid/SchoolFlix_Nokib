import 'package:flutter/material.dart';

import '../../util/appTheme.dart';
import 'myNavDrawerItems.dart';

class MyNavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(

        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.

        child: SingleChildScrollView(
            child: Container(
      height: MediaQuery.of(context).size.height,
      width: 280,
      child: Column(
        // Important: Remove any padding from the ListView
        // padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: 18),
          // rawer header
          Container(
            color: AppTheme.background,
            child: DrawerHeader(
              child: Column(
                children: [
                  Stack(children: [
                    Align(
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          //borderRadius: BorderRadius.all(Radius.circular(25)),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('images/launchu.jpeg'),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    // Positioned.fill(
                    //   child: Align(
                    //     alignment: Alignment(0, 1.5),
                    //     child: Container(
                    //         width: 27,
                    //         height: 27,
                    //         decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           border: Border.all(color: Colors.white),
                    //           //borderRadius: BorderRadius.all(Radius.circular(25)),
                    //           shape: BoxShape.circle,
                    //         ),
                    //         child: IconButton(
                    //             icon: Icon(
                    //               Icons.edit,
                    //               color: Colors.amber,
                    //               size: 10,
                    //             ),
                    //             onPressed: null)),
                    //   ),
                    // )
                  ]),
                  SizedBox(height: 25),
                  Text("SchoolFlix",
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: AppTheme.textBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: 25)),
                ],
              ),
            ),
          ),

          Container(
            height: MediaQuery.of(context).size.height * 0.68,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                new MyDrawerItems().drawerItem(
                    icon: Icons.subscriptions,
                    text: 'Subscribe',
                    onTap: () => {
                          //clossing the nav drawer after click
                          Navigator.pop(context)
                        }),
                SizedBox(
                  height: 10,
                ),
                new MyDrawerItems().drawerItem(
                    icon: Icons.thumb_up,
                    text: 'Rate Us',
                    onTap: () => {
                          //clossing the nav drawer after click
                          Navigator.pop(context)
                        }),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    )));
  }
}
