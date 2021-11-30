import 'package:app_sagem/components/progress.dart';
import 'package:app_sagem/screens/dashboard.dart';
import 'package:app_sagem/screens/login/login.dart';
import 'package:app_sagem/screens/login/register.dart';
import 'package:app_sagem/screens/splash.dart';
import 'package:app_sagem/utils/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Bless());
}

Future<int> logado() async {
  final prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');

  if (token.isNotEmpty) {
    return 1;
  }

  return 0;
}

class Bless extends StatefulWidget {
  @override
  BlessState createState() => BlessState();
}

class BlessState extends State<Bless> {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'pt_BR';

    // FirebaseAuth auth = FirebaseAuth.instance;
    Firebase.initializeApp();
    final Future<int> isLogado = logado();
    print('LOGADOOOOO');
    print(isLogado);
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt'),
      ],
      locale: const Locale('pt'),
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
        primaryColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[100],
          iconTheme: IconThemeData(color: Color(0xFFCC39191)),
          actionsIconTheme: IconThemeData(color: Color(0xFFCC39191)),
          centerTitle: false,
          elevation: 15,
          titleTextStyle: TextStyle(color: Colors.black),
        ),
      ),
      // ignore: unrelated_type_equality_checks
      home: isLogado == 1 ? HomePage() : LoginPage(),
      routes: {
        "/dashboard": (_) => new Dashboard(),
        "/home": (BuildContext context) => HomePage(),
        "/login": (BuildContext context) => LoginPage(),
        "/register": (BuildContext context) => RegisterPage(),
      },
    );
  }
}
