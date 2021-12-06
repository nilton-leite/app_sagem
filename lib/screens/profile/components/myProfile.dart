import 'package:app_sagem/components/empty.dart';
import 'package:app_sagem/components/progress.dart';
import 'package:app_sagem/http/webclients/schedules.dart';
import 'package:app_sagem/http/webclients/user.dart';
import 'package:app_sagem/models/user.dart';
import 'package:app_sagem/screens/home/components/card.dart';
import 'package:app_sagem/screens/home/components/search.dart';
import 'package:app_sagem/screens/home/components/services.dart';
import 'package:app_sagem/utils/color.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:masked_text/masked_text.dart';

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

  static final TextEditingController _name = new TextEditingController();
  static final TextEditingController _telephone = new TextEditingController();
  static final TextEditingController _email = new TextEditingController();
  static final TextEditingController _pass = new TextEditingController();
  static final TextEditingController _confirmPass = new TextEditingController();

  String get name => _name.text;
  String get telephone => _telephone.text;
  String get username => _email.text;
  String get password => _pass.text;
  String get confirmPassword => _confirmPass.text;

  Map<int, Color> color = MapColor.getColor();

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
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        child: Theme(
                          data: ThemeData(
                            brightness: Brightness.dark,
                            primarySwatch: MaterialColor(
                                0xFFCC39191, color), //Colors.blue,
                            inputDecorationTheme: InputDecorationTheme(
                              labelStyle: TextStyle(
                                  color: Color(0xFFCC39191), fontSize: 20.0),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFCC39191),
                                ),
                              ),
                            ),
                          ),
                          child: Container(
                            // margin: const EdgeInsets.only(top: 150.0),
                            padding: const EdgeInsets.all(60.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                TextFormField(
                                  controller: _name,
                                  decoration: InputDecoration(
                                    labelText: "Nome",
                                  ),
                                  keyboardType: TextInputType.text,
                                ),
                                new MaskedTextField(
                                  maskedTextFieldController: _telephone,
                                  mask: "(xx) xxxxx-xxxx",
                                  maxLength: 15,
                                  keyboardType: TextInputType.phone,
                                  inputDecoration: new InputDecoration(
                                      labelText: "Telefone"),
                                ),
                                TextFormField(
                                  controller: _email,
                                  decoration: InputDecoration(
                                    labelText: "E-mail",
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                TextFormField(
                                  controller: _pass,
                                  decoration: InputDecoration(
                                    labelText: "Senha",
                                  ),
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                ),
                                TextFormField(
                                  controller: _confirmPass,
                                  decoration: InputDecoration(
                                    labelText: "Confirme a Senha",
                                  ),
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 20.0)),
                                ElevatedButton(
                                  child: new Text("Alterar dados"),
                                  onPressed: () {
                                    print('OOOOOI');
                                    // save(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFCC39191),
                                    elevation: 1, //elevation of button
                                    shape: RoundedRectangleBorder(
                                      //to set border radius to button
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.all(15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      // _cardsSchedules(),
                    ],
                  ),
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
