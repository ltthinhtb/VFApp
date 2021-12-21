import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/model/response/identity_card.dart';
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

  bool nextStep = false;
  List<CameraDescription> cameras = [];
  late File cmndFront;
  late File cmndBack;
  late File face;

  late String urlCmndFront;
  late String urlCmndBack;
  late String urlFace;
  late String urlSignature;

  IdentityCard identityCard = IdentityCard();
  IdentityCard identityCardBack = IdentityCard();

  final SignatureController signController = SignatureController(
    penStrokeWidth: 5,
    penColor: AppColors.primary,
    exportBackgroundColor:  AppColors.primary,
  );

  SignUpState() {
    checkAccountContinue = ValueNotifier<bool>(false);

    ///Initialize variables
  }
}
