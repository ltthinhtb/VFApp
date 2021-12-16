import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/router/route_config.dart';
import 'package:vf_app/ui/commons/app_snackbar.dart';
import 'package:vf_app/ui/widgets/button/button_filled.dart';
import 'package:vf_app/ui/widgets/button/button_text.dart';
import 'package:vf_app/utils/logger.dart';

import '../sign_up_logic.dart';

class SignUpOTPPage extends StatefulWidget {
  const SignUpOTPPage({Key? key}) : super(key: key);

  @override
  _SignUpOTPPageState createState() => _SignUpOTPPageState();
}

class _SignUpOTPPageState extends State<SignUpOTPPage> {
  final logic = Get.find<SignUpLogic>();
  final state = Get.find<SignUpLogic>().state;

  late String _verificationId;
  ConfirmationResult? webConfirmationResult;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    state.OTPController.clear();
   // _verifyPhoneNumber();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _verifyPhoneNumber() async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
      logger.d('check số điện thoại thành công');
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      logger.e(authException);
      AppSnackBar.showError(
          message: "Hệ thống quá tải vui lòng đợi OTP sau vài phút");
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) async {
      AppSnackBar.showInfo(
          title: "OTP", message: 'Mã OTP đã được gửi tới số điện thoại');
      _verificationId = verificationId;
    };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: state.phoneNameController.text,
          timeout: const Duration(seconds: 60),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      AppSnackBar.showError(message: "Failed to Verify Phone Number: $e");
    }
  }

  Future<void> _signInWithPhoneNumber() async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: state.OTPController.text,
      );
      var user = (await _auth.signInWithCredential(credential)).user!;
      logger.d(user.phoneNumber);
      AppSnackBar.showInfo(title: S.of(context).success);
    } catch (e) {
      logger.e(e);
      AppSnackBar.showError(message: S.of(context).failed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final headline4 = Theme.of(context).textTheme.headline4;
    final headline5 = Theme.of(context).textTheme.headline5;
    final headline6 = Theme.of(context).textTheme.headline6;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).confirm_otp),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Text(S.of(context).please_input_OTP, style: headline6),
          Text(state.phoneNameController.text, style: headline5),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Theme(
              data: Theme.of(context).copyWith(
                  inputDecorationTheme: const InputDecorationTheme(
                fillColor: null,
                filled: false,
              )),
              child: PinPut(
                onChanged: (value) {
                  if (value.length < 6) {}
                },
                onSubmit: (text) async {
                  await _signInWithPhoneNumber();
                },
                textStyle: headline4,
                focusNode: state.OTPFocusNode,
                controller: state.OTPController,
                fieldsCount: 6,
                submittedFieldDecoration: _pinPutDecoration,
                selectedFieldDecoration: _pinPutDecoration.copyWith(
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 1)),
                followingFieldDecoration: _pinPutDecoration,
                autovalidateMode: AutovalidateMode.always,
                eachFieldWidth: 46.0,
                eachFieldHeight: 50.0,
              ),
            ),
          ),
          const SizedBox(height: 30),
          ButtonText(
              voidCallback: () async {
                await _verifyPhoneNumber();
              },
              title: S.of(context).resent),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ButtonFill(
                    voidCallback: () {
                      Get.toNamed(RouteConfig.sign_up_activated);
                    },
                    title: S.of(context).continue_step)),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
        border: Border.all(color: AppColors.line, width: 1),
        borderRadius: BorderRadius.circular(15));
  }
}
