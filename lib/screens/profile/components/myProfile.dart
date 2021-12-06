import 'package:app_sagem/components/empty.dart';
import 'package:app_sagem/components/progress.dart';
import 'package:app_sagem/http/webclients/schedules.dart';
import 'package:app_sagem/http/webclients/user.dart';
import 'package:app_sagem/models/user.dart';
import 'package:app_sagem/screens/home/components/card.dart';
import 'package:app_sagem/screens/home/components/search.dart';
import 'package:app_sagem/screens/home/components/services.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({
    Key key,
  }) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final UserWebClient _webclient = UserWebClient();
  List<UserBless> user = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F3EE),
      appBar: AppBar(
        titleSpacing: 0,
        automaticallyImplyLeading: true,
        title: Text(
          'Meus Dados',
          style: GoogleFonts.dancingScript(
            textStyle: TextStyle(
              color: Color(0xFFCC39191),
              letterSpacing: .5,
              fontSize: 40,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: FutureBuilder<List>(
        initialData: [],
        future: _webclient?.get(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                user = snapshot.data;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                    ),
                    // _cardsSchedules(),
                  ],
                );
              }
              return Empty(
                title: 'Sem informações de perfil',
                subtitle: 'Não encontramos informações do seu perfil!',
                image: PackageImage.Image_3,
                button: false,
                textState: null,
              );
          }
          return Empty(
            title: 'Ops... Sem internet',
            subtitle: 'Verifique sua conexão com a internet e tente de novo',
            image: PackageImage.Image_2,
            button: false,
            textState: null,
          );
        },
      ),
    );
  }
}
