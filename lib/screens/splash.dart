import 'package:app_sagem/screens/dashboard.dart';
import 'package:app_sagem/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

class HomePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<HomePage> {
  int isLogado = 0;

  @override
  void initState() {
    super.initState();
    _isLogado();
  }

  void _isLogado() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogado = (prefs.getString('token') != null ? 1 : 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SplashScreen(
            seconds: 5,
            navigateAfterSeconds: isLogado == 1 ? Dashboard() : LoginPage(),
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
            loaderColor: Color(0xFFCC39191),
          )
        ],
      ),
    );
  }
}
