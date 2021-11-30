import 'package:app_sagem/http/webclients/login.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:app_sagem/utils/navigator.dart';
import 'package:app_sagem/models/user.dart';
import 'package:masked_text/masked_text.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
  /// Variáveis de animação
  AnimationController _iconAnimationController;
  AnimationController _formAnimationController;
  Animation<double> _iconAnimation;
  Animation<double> _formAnimation;

  /// Variáveis de formulário
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

  final LoginWebClient _webclient = LoginWebClient();

  Map<String, dynamic> validateForm() {
    Map<String, dynamic> validate = {"status": true, "message": null};

    if (name.isEmpty) {
      validate['status'] = false;
      validate['message'] = "Ops... Campo nome é obrigatório!";
    } else if (telephone.isEmpty) {
      validate['status'] = false;
      validate['message'] = "Ops... Campo telefone é obrigatório!";
    } else if (username.isEmpty) {
      validate['status'] = false;
      validate['message'] = "Ops... Campo email é obrigatório!";
    } else if (!EmailValidator.validate(username)) {
      validate['status'] = false;
      validate['message'] = "Ops... Email fornecido inválido!";
    } else if (password.isEmpty) {
      validate['status'] = false;
      validate['message'] = "Ops... Campo senha é obrigatório!";
    } else if (password != confirmPassword) {
      validate['status'] = false;
      validate['message'] = "Ops... As senhas não conferem!";
    }

    return validate;
  }

  void save(BuildContext context) async {
    Map<String, dynamic> validate = validateForm();
    print('validate');
    print(validate);
    if (!validate['status']) {
      final snackBar = SnackBar(
        content: Text(validate['message']),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      Map<String, dynamic> resposta = await _webclient.validateUser(username);
      var snackBar;
      if (resposta['status']) {
        try {
          print('Aqui antes de ir no firebase');
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: username, password: password);

          Map<String, dynamic> user = await _webclient.save(name, telephone,
              username, userCredential.user.uid, 'null', 'null');

          if (user['_id'] != null) {
            snackBar = SnackBar(
              content: Text('Parabéns! Cadastro efetuado com sucesso.'),
              backgroundColor: Color(0xFFCC39191),
              action: SnackBarAction(
                label: 'Logar',
                textColor: Colors.white70,
                onPressed: () {
                  login(context);
                },
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          print('user Aqui meu amigo');
          print(user);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            snackBar = SnackBar(
              content: Text('Ops... A senha fornecida é muito fraca!'),
              backgroundColor: Colors.redAccent,
            );
          } else if (e.code == 'email-already-in-use') {
            snackBar = SnackBar(
              content: Text('Ops... Email fornecido já cadastrado!'),
              backgroundColor: Colors.redAccent,
            );
          }

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } catch (e) {
          print(e);
          snackBar = SnackBar(
            content: Text('Ops... Campos fornecidos inválidos!'),
            backgroundColor: Colors.redAccent,
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        final snackBar = SnackBar(
          content: Text('Ops... Email fornecido já cadastrado!'),
          backgroundColor: Colors.redAccent,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  void login(BuildContext context) {
    FirebaseAuthAppNavigator.goToLogin(context);
  }

  Future<Null> _playAnimation() async {
    try {
      await _iconAnimationController.forward().orCancel;
      await _formAnimationController.forward().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    _formAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 1000));

    _formAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_formAnimationController);
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.easeOut);

    _iconAnimation.addListener(() => this.setState(() {}));

    _playAnimation();

    _name.clear();
    _telephone.clear();
    _email.clear();
    _pass.clear();
    _confirmPass.clear();
  }

  @override
  void dispose() {
    _formAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(136, 14, 79, .1),
      100: Color.fromRGBO(136, 14, 79, .2),
      200: Color.fromRGBO(136, 14, 79, .3),
      300: Color.fromRGBO(136, 14, 79, .4),
      400: Color.fromRGBO(136, 14, 79, .5),
      500: Color.fromRGBO(136, 14, 79, .6),
      600: Color.fromRGBO(136, 14, 79, .7),
      700: Color.fromRGBO(136, 14, 79, .8),
      800: Color.fromRGBO(136, 14, 79, .9),
      900: Color.fromRGBO(136, 14, 79, 1),
    };
    return Scaffold(
      backgroundColor: Colors.black,
      body: Builder(
        builder: (context) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image(
                image: new AssetImage("images/bless_white.png"),
                fit: BoxFit.cover,
                color: Colors.black54,
                colorBlendMode: BlendMode.darken,
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FadeTransition(
                      opacity: _formAnimation,
                      child: Form(
                        child: Theme(
                          data: ThemeData(
                              brightness: Brightness.dark,
                              primarySwatch: MaterialColor(
                                  0xFFCC39191, color), //Colors.blue,
                              inputDecorationTheme: InputDecorationTheme(
                                  labelStyle: TextStyle(
                                      color: Color(0xFFCC39191),
                                      fontSize: 20.0))),
                          child: Container(
                            margin: const EdgeInsets.only(top: 150.0),
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
                                MaterialButton(
                                  height: 40.0,
                                  minWidth: 100.0,
                                  color: Color(0xFFCC39191),
                                  textColor: Colors.white70,
                                  child: new Text("Cadastrar"),
                                  onPressed: () {
                                    save(context);
                                  },
                                  splashColor: Colors.blue,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                ),
                                MaterialButton(
                                  height: 40.0,
                                  minWidth: 100.0,
                                  color: Colors.black45,
                                  textColor: Colors.white70,
                                  child: new Text("Logar"),
                                  onPressed: () {
                                    login(context);
                                  },
                                  splashColor: Color(0xFFCC39191),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
