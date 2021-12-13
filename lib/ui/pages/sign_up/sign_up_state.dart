import 'package:flutter/material.dart';

class SignUpState {
  final TextEditingController pinPutController = TextEditingController();
  final FocusNode pinPutFocusNode = FocusNode();
  final formKeyPIN = GlobalKey<FormState>();

  late ValueNotifier<bool> checkAccountContinue;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNameController = TextEditingController();
  final TextEditingController emailNameController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController referralCodeController = TextEditingController();

  FocusNode fullNameFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passFocus = FocusNode();
  FocusNode referralCodeFocus = FocusNode();

  final formFullName = GlobalKey<FormState>();
  final formPhone = GlobalKey<FormState>();
  final formEmail = GlobalKey<FormState>();
  final formPass = GlobalKey<FormState>();

  bool agreePolicy = false;

  SignUpState() {
    checkAccountContinue = ValueNotifier<bool>(false);

    ///Initialize variables
  }
}
