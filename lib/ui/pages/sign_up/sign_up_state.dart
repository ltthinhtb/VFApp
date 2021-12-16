import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:vf_app/ui/pages/sign_up/widget/alert_dialog.dart';

class SignUpState {
  final TextEditingController pinPutController = TextEditingController();
  final FocusNode pinPutFocusNode = FocusNode();
  final formKeyPIN = GlobalKey<FormState>();

  final TextEditingController OTPController = TextEditingController();
  final FocusNode OTPFocusNode = FocusNode();

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

  EnumRadio enumRadio = EnumRadio.values.first;

  List<CameraDescription> cameras = [];

  SignUpState() {
    checkAccountContinue = ValueNotifier<bool>(false);

    ///Initialize variables
  }
}
