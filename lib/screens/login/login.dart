import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:app_sagem/utils/navigator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  /// Variáveis de animação
  AnimationController _iconAnimationController;
  AnimationController _formAnimationController;
  Animation<double> _iconAnimation;
  Animation<double> _formAnimation;

  /// Variáveis de formulário
  static final TextEditingController _email = new TextEditingController();
  static final TextEditingController _pass = new TextEditingController();

  String get username => _email.text;
  String get password => _pass.text;

  void doLogin(BuildContext context) async {
    if (username.isNotEmpty || password.isNotEmpty) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: username, password: password);
        FirebaseAuthAppNavigator.goToHome(context);
      } on FirebaseAuthException catch (e) {
        final snackBar = SnackBar(
          content: Text('Usuário ou senha incorretos'),
          backgroundColor: Colors.redAccent,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      final snackBar = SnackBar(
        content: Text('Ops... Campos fornecidos inválidos!'),
        backgroundColor: Colors.redAccent,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void register(BuildContext context) {
    FirebaseAuthAppNavigator.goToRegister(context);
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

    _email.clear();
    _pass.clear();
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
              Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                  Widget>[
                FadeTransition(
                  opacity: _formAnimation,
                  child: Form(
                    child: Theme(
                      data: ThemeData(
                          brightness: Brightness.dark,
                          primarySwatch:
                              MaterialColor(0xFFCC39191, color), //Colors.blue,
                          inputDecorationTheme: InputDecorationTheme(
                              labelStyle: TextStyle(
                                  color: Color(0xFFCC39191), fontSize: 20.0))),
                      child: Container(
                        padding: const EdgeInsets.all(60.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              controller: _email,
                              decoration: InputDecoration(
                                labelText: "Insira o e-mail",
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            TextFormField(
                              controller: _pass,
                              decoration: InputDecoration(
                                labelText: "Insira a senha",
                              ),
                              keyboardType: TextInputType.text,
                              obscureText: true,
                            ),
                            Padding(padding: const EdgeInsets.only(top: 20.0)),
                            MaterialButton(
                              height: 40.0,
                              minWidth: 100.0,
                              color: Color(0xFFCC39191),
                              textColor: Colors.white70,
                              child: new Text("Entrar"),
                              onPressed: () {
                                doLogin(context);
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
                              child: new Text("Cadastrar"),
                              onPressed: () {
                                register(context);
                              },
                              splashColor: Color(0xFFCC39191),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
