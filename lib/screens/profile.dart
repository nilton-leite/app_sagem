import 'package:app_sagem/utils/navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  void logout(BuildContext context) async {
    print('Estou aqui');
    await FirebaseAuth.instance.signOut();
    print('Singnal');
    FirebaseAuthAppNavigator.goToLogin(context);
    print('Após');
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
