import 'package:app_sagem/components/progress.dart';
import 'package:app_sagem/screens/dashboard.dart';
import 'package:app_sagem/screens/login/login.dart';
import 'package:app_sagem/screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Bless());
}

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [App] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
class Bless extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  BlessState createState() => BlessState();
}

/// This is the main application widget.
class BlessState extends State<Bless> {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'pt_BR';

    // FirebaseAuth auth = FirebaseAuth.instance;
    Firebase.initializeApp();

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
            iconTheme: IconThemeData(color: Colors.amber[800]),
            actionsIconTheme: IconThemeData(color: Colors.amber[800]),
            centerTitle: false,
            elevation: 15,
            titleTextStyle: TextStyle(color: Colors.black),
          ),
        ),
        home: LoginPage(),
        routes: {
          "/dashboard": (_) => new Dashboard(),
          "/home": (BuildContext context) => HomePage(),
          "/login": (BuildContext context) => LoginPage(),
        });
    // return FutureBuilder(
    //   // Initialize FlutterFire:
    //   future: _initialization,
    //   builder: (context, snapshot) {
    //     // Check for errors
    //     if (snapshot.hasError) {
    //       return SnackBar(
    //         content: Text(
    //           "Erro ao inicializar APP",
    //         ),
    //         backgroundColor: Colors.redAccent,
    //       );
    //     }

    //     // Once complete, show your application
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       return MaterialApp(
    //           localizationsDelegates: [
    //             GlobalMaterialLocalizations.delegate,
    //             GlobalWidgetsLocalizations.delegate,
    //           ],
    //           supportedLocales: [
    //             const Locale('pt'),
    //           ],
    //           locale: const Locale('pt'),
    //           debugShowCheckedModeBanner: false,
    //           title: _title,
    //           theme: ThemeData(
    //             primaryColor: Colors.white,
    //             appBarTheme: AppBarTheme(
    //               backgroundColor: Colors.grey[100],
    //               iconTheme: IconThemeData(color: Colors.amber[800]),
    //               actionsIconTheme: IconThemeData(color: Colors.amber[800]),
    //               centerTitle: false,
    //               elevation: 15,
    //               titleTextStyle: TextStyle(color: Colors.black),
    //             ),
    //           ),
    //           home: LoginPage(),
    //           routes: {
    //             "/dashboard": (_) => new Dashboard(),
    //             "/home": (BuildContext context) => HomePage(),
    //             "/login": (BuildContext context) => LoginPage(),
    //           });
    //     }

    //     // Otherwise, show something whilst waiting for initialization to complete
    //     return Text('data');
    //   },
    // );
  }
}
