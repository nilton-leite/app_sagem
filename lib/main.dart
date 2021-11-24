import 'package:app_sagem/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

void main() => runApp(const Bless());

/// This is the main application widget.
class Bless extends StatelessWidget {
  const Bless({Key key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'pt_BR';
    // initializeDateFormatting();
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
      home: HomePage(),
    );
  }
}
