import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:school_flix_flutter/Services/videoInformationService.dart';
import 'package:school_flix_flutter/util/appTheme.dart';

import 'Screens/DashboardScreen/dashBorad.dart';

void setUpLocator() {
  GetIt.I.registerLazySingleton(() => VideoInformationService());
}

void main() {
  setUpLocator();

 
   
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'School Flix',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
                //borderRadius: BorderRadius.all(Radius.circular(25)),
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('images/launchu.jpeg'),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Welcome to SchoolFlix",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w800,color: AppTheme.textBlue)),
            SizedBox(
              height: 100,
            ),
            startButton(),
          ],
        ),
      ),
    );
  }

  Widget startButton() {
    return SizedBox(
      height: 40,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: Container(
          // margin: EdgeInsets.only(top: 0.0),
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            // boxShadow: <BoxShadow>[
            //   BoxShadow(
            //     color: Colors.black12,
            //     offset: Offset(1.0, 6.0),
            //     blurRadius: 20.0,
            //   ),
            //   BoxShadow(
            //     color: Colors.black12,
            //     offset: Offset(1.0, 6.0),
            //     blurRadius: 20.0,
            //   ),
            // ],
            gradient: new LinearGradient(
                colors: [
                  AppTheme.textBlue,
                   AppTheme.textBlue
                ],
                begin: const FractionalOffset(0.0, 1.0),
                end: const FractionalOffset(0.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: MaterialButton(
              highlightColor: AppTheme.textBlue,
              splashColor: AppTheme.textBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 82.0),
                child: Text("Start Learning",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white)),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DashBoard()));
              }

              // showInSnackBar("Login button pressed")

              ),
        ),
      ),
    );
  }
}
