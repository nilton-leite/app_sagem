import 'package:flutter/material.dart';

class FirebaseAuthAppNavigator {
  static void goToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/home");
  }

  static void goToLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/login");
  }

  static void goToRegister(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/register");
  }
}
