import 'package:flutter/material.dart';
import 'package:school_flix_flutter/Screens/DashboardScreen/bottomNavDestinations.dart';

import 'package:school_flix_flutter/util/appTheme.dart';
import 'package:school_flix_flutter/Screens/AboutScreen/aboutScreen.dart';
import 'package:school_flix_flutter/Screens/VideosScreen/videoScreenHome.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _currentIndex = 0;

  final allScreenDestiNations = [
    VideoScreenHome(),
    AboutScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
    color: AppTheme.textBlue, //change your color here
  ),
            backgroundColor: AppTheme.background,
            title:
                Text("SchoolFlix", style: TextStyle(color: AppTheme.textBlue))),
        body: SafeArea(
          top: false,
          child: IndexedStack(
              index: _currentIndex, children: allScreenDestiNations),
        ),
        //drawer: MyNavDrawer(),
        bottomNavigationBar: SizedBox(
          height: 45,
          child: BottomNavigationBar(
             backgroundColor: AppTheme.background,
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: allDestinations.map((Destination destination) {
              return BottomNavigationBarItem(
                  icon: Icon(
                    destination.icon,
                    color: AppTheme.textBlue,
                    size: 17,
                  ),
                  backgroundColor: AppTheme.background,
                  title: Text(
                    destination.title,
                    style: TextStyle(color: AppTheme.textBlue, fontSize: 12),
                  ));
            }).toList(),
          ),
        ),
      ),
    );
  }
}
