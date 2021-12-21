import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/common/app_images.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/ui/widgets/button/button_text.dart';
import 'package:vf_app/ui/widgets/textfields/app_text_field.dart';
import 'package:vf_app/utils/utils.dart';
import 'package:vf_app/utils/validator.dart';

import 'sign_in_logic.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with Validator {
  final logic = Get.put(SignInLogic());
  final state = Get.find<SignInLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Utils.dismissKeyboard(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 84),
              Container(
                alignment: Alignment.center,
                height: 70,
                width: 160,

                child: Image.asset(
                  "assets/image/logo.png",
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text(
                      S.of(context).login,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: state.formKeyUser,
                      child: AppTextFieldWidget(
                        inputController: state.usernameTextController,
                        label: S.of(context).user_name,
                        hintText: S.of(context).please_input_user,
                        validator: (value) => checkUser(value!),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: state.formKeyPass,
                      child: AppTextFieldWidget(
                        obscureText: true,
                        inputController: state.passwordTextController,
                        label: S.of(context).password,
                        hintText: S.of(context).please_input_password,
                        validator: (value) => checkPass(value!),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Align(
                        alignment: Alignment.centerRight,
                        child: ButtonText(
                          voidCallback: () {},
                          title: S.of(context).forgot_pass,
                        )),
                    const SizedBox(height: 37),
                    ButtonText(
                      voidCallback: () {},
                      title: "Truy cập nhanh vào smart OTP",
                      textStyle: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(
                              color: AppColors.green,
                              fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          logic.signIn();
                        },
                        child: Text(S.of(context).login),
                      ),
                    ),
                    const SizedBox(height: 15),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: S.of(context).not_account,
                            style: Theme.of(context).textTheme.bodyText1,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => print('Tap Here onTap'),
                          ),
                          TextSpan(
                            text: S.of(context).register,
                            style: Theme.of(context).textTheme.button!.copyWith(
                                color: Theme.of(context).primaryColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => print('Tap Here onTap'),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SvgPicture.asset(AppImages.finger),
                    const SizedBox(height: 22),
                    TextButton(
                        onPressed: () {},
                        child: Text(S.of(context).policy_use)),
                    const SizedBox(height: 22),
                    TextButton(
                        onPressed: () {},
                        child: Text(S.of(context).contact_support)),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<SignInLogic>();
    super.dispose();
  }
}
