import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/ui/widgets/button/button_filled.dart';
import 'package:vf_app/ui/widgets/check_box/app_check_box.dart';
import 'package:vf_app/ui/widgets/textfields/app_text_field.dart';
import 'package:vf_app/utils/validator.dart';

import '../sign_up_logic.dart';

class SignUpFormPage extends StatefulWidget {
  const SignUpFormPage({Key? key}) : super(key: key);

  @override
  _SignUpFormPageState createState() => _SignUpFormPageState();
}

class _SignUpFormPageState extends State<SignUpFormPage> with Validator {
  final logic = Get.find<SignUpLogic>();
  final state = Get.find<SignUpLogic>().state;

  @override
  Widget build(BuildContext context) {
    final headline4 = Theme.of(context).textTheme.headline4;
    final headline6 = Theme.of(context)
        .textTheme
        .headline6!
        .copyWith(fontWeight: FontWeight.w700);
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).register_form),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                alignment: Alignment.center,
                height: 70,
                width: 160,
                decoration: BoxDecoration(
                  color: AppColors.grayC4,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'Logo',
                  style: headline4,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: state.formFullName,
                child: AppTextFieldWidget(
                  inputController: state.fullNameController,
                  label: S.of(context).full_name,
                  focusNode: state.fullNameFocus,
                  validator: (value) {
                    return checkFullName(value!);
                  },
                  onFieldSubmitted: (value) {
                    if (state.formFullName.currentState!.validate()) {
                      FocusScope.of(context).requestFocus(state.phoneFocus);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: state.formPhone,
                child: AppTextFieldWidget(
                  inputController: state.phoneNameController,
                  label: S.of(context).phone,
                  focusNode: state.phoneFocus,
                  textInputType: TextInputType.phone,
                  validator: (phoneNumber) => checkPhoneNumber(phoneNumber!),
                  onFieldSubmitted: (value) {
                    if (state.formPhone.currentState!.validate()) {
                      FocusScope.of(context).requestFocus(state.emailFocus);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: state.formEmail,
                child: AppTextFieldWidget(
                  inputController: state.emailNameController,
                  label: S.of(context).email,
                  focusNode: state.emailFocus,
                  validator: (email) => checkEmail(email!),
                  onFieldSubmitted: (value) {
                    if (state.formEmail.currentState!.validate()) {
                      FocusScope.of(context).requestFocus(state.passFocus);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: state.formPass,
                child: AppTextFieldWidget(
                  inputController: state.passController,
                  label: S.of(context).password,
                  focusNode: state.passFocus,
                  validator: (value) => checkPass(value!),
                  obscureText: true,
                  onFieldSubmitted: (value) {
                    if (state.formPass.currentState!.validate()) {
                      FocusScope.of(context)
                          .requestFocus(state.referralCodeFocus);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: AppTextFieldWidget(
                inputController: state.referralCodeController,
                label: S.of(context).referral_code,
                focusNode: state.referralCodeFocus,
                onFieldSubmitted: (value) {
                  logic.checkPhoneEmail();
                },
              ),
            ),
            const SizedBox(height: 11),
            Row(
              children: [
                Theme(
                  data: Theme.of(context)
                      .copyWith(unselectedWidgetColor: Colors.grey),
                  child: AppCheckBox(
                    value: state.agreePolicy,
                    onChanged: (value) {
                      state.agreePolicy = !state.agreePolicy;
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                    child: RichText(
                  text: TextSpan(children: [
                    TextSpan(text: S.of(context).agree, style: bodyText1),
                    TextSpan(
                        text: ' ${S.of(context).terms_and_condition}',
                        style: headline6.copyWith(
                            color: Theme.of(context).primaryColor))
                  ]),
                ))
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonFill(
                      voidCallback: () {
                        logic.checkPhoneEmail();
                      }, title: S.of(context).sign_up)),
            ),
          ],
        ),
      ),
    );
  }
}
