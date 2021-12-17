import 'package:app_sagem/components/customDialogBox.dart';
import 'package:app_sagem/screens/profile/components/myNotifications.dart';
import 'package:app_sagem/screens/profile/components/myProfile.dart';
import 'package:app_sagem/screens/profile/components/mySchedules.dart';
import 'package:app_sagem/screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatelessWidget {
  void logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    prefs.remove('token');
    prefs.remove('name');
    prefs.remove('telephoen');
    final navigator = Navigator.of(context);

    navigator.popUntil((route) => route.isFirst);
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F3EE),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Perfil',
                  style: GoogleFonts.dancingScript(
                    textStyle: TextStyle(
                      color: Color(0xFFCC39191),
                      letterSpacing: .5,
                      fontSize: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(5),
              width: double.infinity,
              child: ListView(
                children: <Widget>[
                  InkResponse(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MyProfile(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                      ),
                      title: Text(
                        'Meus dados',
                      ),
                    ),
                  ),
                  InkResponse(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MySchedules(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.view_list_outlined,
                      ),
                      title: Text(
                        'Meus agendamentos',
                      ),
                    ),
                  ),
                  InkResponse(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MyNotifications(),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.circle_notifications_rounded,
                      ),
                      title: Text(
                        'Minhas notificações',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            // This align moves the children to the bottom
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              // This container holds all the children that will be aligned
              // on the bottom and should not scroll with the above ListView
              child: Container(
                child: Column(
                  children: <Widget>[
                    Divider(),
                    InkResponse(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext contextDialog) {
                            return CustomDialogBox(
                                title: "Deseja realmente sair?",
                                descriptions:
                                    "Que pena, mas volte logo hein, já estamos com saudade :)",
                                textConfirm: "Sair",
                                textCancel: "Não",
                                function: () async {
                                  logout(context);
                                });
                          },
                        );
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.exit_to_app_rounded,
                          color: Colors.redAccent,
                        ),
                        title: Text(
                          'Sair',
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
