import 'package:app_sagem/screens/home.dart';
import 'package:app_sagem/screens/profile.dart';
import 'package:app_sagem/screens/services.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Chloe());

/// This is the main application widget.
class Chloe extends StatelessWidget {
  const Chloe({Key? key}) : super(key: key);

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
          // This will be applied to the "back" icon
          iconTheme: IconThemeData(color: Colors.red),
          // This will be applied to the action icon buttons that locates on the right side
          actionsIconTheme: IconThemeData(color: Colors.amber),
          centerTitle: false,
          elevation: 15,
          titleTextStyle: TextStyle(color: Colors.black),
        ),
      ),
      home: Dashboard(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<Dashboard> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'Chloe',
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   backgroundColor: Colors.white,
      // ),
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          Home(),
          Services(),
          Profile(),
        ],
      ),

      // Center(
      //   child: _widgetOptions.elementAt(_selectedIndex),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_rows),
            label: 'Serviços',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
