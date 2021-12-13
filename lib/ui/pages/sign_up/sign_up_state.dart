import 'package:flutter/material.dart';

class SignUpState {
  final TextEditingController pinPutController = TextEditingController();
  final FocusNode pinPutFocusNode = FocusNode();
  final formKeyPIN = GlobalKey<FormState>();

  late ValueNotifier<bool> checkAccountContinue;

  SignUpState() {
    checkAccountContinue = ValueNotifier<bool>(false);

    ///Initialize variables
  }
}
