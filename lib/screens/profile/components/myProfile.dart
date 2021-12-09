import 'package:app_sagem/components/empty.dart';
import 'package:app_sagem/components/progress.dart';
import 'package:app_sagem/http/webclients/user.dart';
import 'package:app_sagem/models/user.dart';
import 'package:app_sagem/utils/color.dart';
import 'package:email_validator/email_validator.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  static final TextEditingController _currentPass = new TextEditingController();
  static final TextEditingController _pass = new TextEditingController();
  static final TextEditingController _confirmPass = new TextEditingController();

  String get name => _name.text;
  String get telephone => _telephone.text;
  String get username => _email.text;
  String get currentPassword => _currentPass.text;
  String get password => _pass.text;
  String get confirmPassword => _confirmPass.text;

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

  Map<String, dynamic> validatePassword() {
    Map<String, dynamic> validate = {"status": true, "message": null};

    if (currentPassword.isEmpty) {
      validate['status'] = false;
      validate['message'] = "Ops... Campo senha atual é obrigatório!";
    } else if (password != confirmPassword) {
      validate['status'] = false;
      validate['message'] = "Ops... As senhas não conferem!";
    } else if (password != confirmPassword) {
      validate['status'] = false;
      validate['message'] = "Ops... As senhas não conferem!";
    }

    return validate;
  }

  void savePassowrd(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> validate = validatePassword();
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
      var snackBar;
      try {
        final user = FirebaseAuth.instance.currentUser;
        final cred = EmailAuthProvider.credential(
            email: user.email, password: currentPassword);
        user.reauthenticateWithCredential(cred).then((value) {
          user.updatePassword(confirmPassword).then((_) {
            setState(() {
              isLoading = false;
            });
            snackBar = SnackBar(
              content: Text('Parabéns! Senha alterada com sucesso.'),
              backgroundColor: Color(0xFFCC39191),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            _currentPass.clear();
            _pass.clear();
            _confirmPass.clear();
            //Success, do something
          }).catchError((error) {
            print('error.code');
            print(error.code);
            print("Password can't be changed" + error.toString());
            setState(() {
              isLoading = false;
            });
            snackBar = SnackBar(
              content: Text(error.toString()),
              backgroundColor: Colors.redAccent,
            );
            //Error, show something
          });
        });
      } on FirebaseAuthException catch (e) {
        print(e.toString());
        setState(() {
          isLoading = false;
        });
        if (e.code == 'user-not-found') {
          snackBar = SnackBar(
            content: Text('Nenhum usuário encontrado.'),
            backgroundColor: Colors.redAccent,
          );
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          snackBar = SnackBar(
            content: Text('Ops.. Senha muito fraca.'),
            backgroundColor: Colors.redAccent,
          );
          print('Wrong password provided for that user.');
        }
        snackBar = SnackBar(
          content: Text(e.code),
          backgroundColor: Colors.redAccent,
        );
      }
    }
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
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFF6F3EE),
      appBar: AppBar(
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

                setarDadosBanco(user[0]);
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 5, left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Dados Básicos',
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
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 10),
                      // ),
                      Divider(
                        height: 20,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
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
                            padding: const EdgeInsets.all(20.0),
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
                                SizedBox(
                                  width: double.maxFinite,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      save(context);
                                    },
                                    child: Text("Alterar cadastro"),
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFFCC39191),
                                      textStyle: TextStyle(color: Colors.white),
                                      elevation: 1, //elevation of button
                                      shape: RoundedRectangleBorder(
                                        //to set border radius to button
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.all(15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 40, left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Alterar senha',
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
                      Divider(
                        height: 20,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
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
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                TextFormField(
                                  controller: _currentPass,
                                  decoration: InputDecoration(
                                    labelText: "Senha atual",
                                  ),
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                ),
                                TextFormField(
                                  controller: _pass,
                                  decoration: InputDecoration(
                                    labelText: "Nova senha",
                                  ),
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                ),
                                TextFormField(
                                  controller: _confirmPass,
                                  decoration: InputDecoration(
                                    labelText: "Confirme a nova senha",
                                  ),
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                ),
                                SizedBox(
                                  width: double.maxFinite,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      savePassowrd(context);
                                    },
                                    child: Text("Alterar senha"),
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFFCC39191),
                                      textStyle: TextStyle(color: Colors.white),
                                      elevation: 1, //elevation of button
                                      shape: RoundedRectangleBorder(
                                        //to set border radius to button
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.all(15),
                                    ),
                                  ),
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
