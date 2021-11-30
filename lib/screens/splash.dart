import 'package:app_sagem/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class HomePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SplashScreen(
            seconds: 5,
            navigateAfterSeconds: Dashboard(),
            image: Image.asset(
              'images/bless_white.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            backgroundColor: Colors.black,
            styleTextUnderTheLoader: new TextStyle(),
            photoSize: 100.0,
            onClick: () => print("Flutter Egypt"),
            loaderColor: Colors.amber[800],
          )
        ],
      ),
    );
  }
}
