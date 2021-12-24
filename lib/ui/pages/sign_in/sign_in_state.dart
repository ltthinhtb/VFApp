import 'package:flutter/material.dart';

class SignInState {
  late TextEditingController usernameTextController;
  late TextEditingController passwordTextController;
  final formKeyUser = GlobalKey<FormState>();
  final formKeyPass = GlobalKey<FormState>();

  SignInState() {
    usernameTextController = TextEditingController(text: '888888');
    passwordTextController = TextEditingController(text: "123456");
  }
}
