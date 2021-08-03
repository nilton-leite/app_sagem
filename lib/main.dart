import 'package:app_sagem/screens/dashboard.dart';
import 'package:app_sagem/screens/splash.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Chloe());

/// This is the main application widget.
class Chloe extends StatelessWidget {
  const Chloe({Key key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[100],
          iconTheme: IconThemeData(color: Colors.red),
          actionsIconTheme: IconThemeData(color: Colors.amber),
          centerTitle: false,
          elevation: 15,
          titleTextStyle: TextStyle(color: Colors.black),
        ),
      ),
      home: HomePage(),
    );
  }
}
