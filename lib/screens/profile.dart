import 'package:app_sagem/utils/navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatelessWidget {
  void logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    prefs.remove('token');
    prefs.remove('name');
    prefs.remove('telephoen');
    FirebaseAuthAppNavigator.goToLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        InkResponse(
          onTap: () {
            logout(context);
          },
          child: Card(
            child: ListTile(
              leading: FlutterLogo(),
              title: Text('Sair'),
            ),
          ),
        ),
      ],
    );
  }
}
