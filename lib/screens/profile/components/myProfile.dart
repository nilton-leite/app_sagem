import 'package:app_sagem/components/empty.dart';
import 'package:app_sagem/components/progress.dart';
import 'package:app_sagem/http/webclients/user.dart';
import 'package:app_sagem/models/user.dart';
import 'package:app_sagem/utils/color.dart';
import 'package:email_validator/email_validator.dart';
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

  String get name => _name.text;
  String get telephone => _telephone.text;
  String get username => _email.text;

  Map<int, Color> color = MapColor.getColor();
  bool isLoading = false;

  void setarDadosBanco(UserBless user) {
    _name.text = user.fullName;
    _telephone.text = user.telephone;
    _email.text = user.email;
  }

  Map<String, dynamic> validateForm() {
    Map<String, dynamic> validate = {"status": true, "message": null};

    if (name.isEmpty) {
      validate['status'] = false;
      validate['message'] = "Ops... Campo nome é obrigatório!";
    } else if (telephone.isEmpty) {
      validate['status'] = false;
      validate['message'] = "Ops... Campo telefone é obrigatório!";
    }

    return validate;
  }

  void save(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> validate = validateForm();
    var snackBar;
    if (!validate['status']) {
      setState(() {
        isLoading = false;
      });
      final snackBar = SnackBar(
        content: Text(validate['message']),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      try {
        Map<String, dynamic> user = await _webclient.save(name, telephone);

        if (user['_id'] != null) {
          setState(() {
            isLoading = false;
          });
          snackBar = SnackBar(
            content: Text('Parabéns! Cadastro alterado com sucesso.'),
            backgroundColor: Color(0xFFCC39191),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          setState(() {
            isLoading = false;
          });
          snackBar = SnackBar(
            content: Text(
                'Ocorreu um erro ao alterar. Por favor, tente novamente mais tarde'),
            backgroundColor: Colors.redAccent,
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        snackBar = SnackBar(
          content: Text(
              'Ocorreu um erro ao alterar. Por favor, tente novamente mais tarde'),
          backgroundColor: Colors.redAccent,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              save(context);
            },
          )
        ],
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

                setarDadosBanco(user[0]);
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        child: Theme(
                          data: ThemeData(
                            textTheme: Theme.of(context).textTheme.apply(
                                  bodyColor: Colors.black,
                                  displayColor: Colors.black,
                                ),
                            brightness: Brightness.dark,
                            primarySwatch: MaterialColor(0xFFCC39191, color),
                            inputDecorationTheme: InputDecorationTheme(
                              labelStyle: TextStyle(
                                color: Color(0xFFCC39191),
                                fontSize: 20.0,
                              ),
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
                                    labelText: "Telefone",
                                  ),
                                ),
                                TextFormField(
                                  controller: _email,
                                  enableInteractiveSelection: false,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    labelText: "E-mail",
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
      // bottomNavigationBar: Padding(
      //   padding: EdgeInsets.all(8.0),
      //   child: isLoading
      //       ? Progress()
      //       : ElevatedButton(
      //           onPressed: () async {
      //             save(context);
      //           },
      //           child: Text("Alterar cadastro"),
      //           style: ElevatedButton.styleFrom(
      //             primary: Color(0xFFCC39191),
      //             elevation: 1, //elevation of button
      //             shape: RoundedRectangleBorder(
      //               //to set border radius to button
      //               borderRadius: BorderRadius.circular(10),
      //             ),
      //             padding: EdgeInsets.all(15),
      //           ),
      //         ),
      // ),
    );
  }
}
