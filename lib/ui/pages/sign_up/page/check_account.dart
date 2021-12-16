import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/common/app_images.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/router/route_config.dart';
import 'package:vf_app/ui/commons/appbar.dart';
import 'package:vf_app/ui/widgets/button/button_filled.dart';

import '../sign_up_logic.dart';

class CheckAccountPage extends StatefulWidget {
  const CheckAccountPage({Key? key}) : super(key: key);

  @override
  _CheckAccountPageState createState() => _CheckAccountPageState();
}

class _CheckAccountPageState extends State<CheckAccountPage> {
  final logic = Get.find<SignUpLogic>();
  final state = Get.find<SignUpLogic>().state;

  @override
  Widget build(BuildContext context) {
    final headline4 = Theme.of(context).textTheme.headline4;
    return Scaffold(
      appBar: AppBarCustom(title: S.of(context).select_account,),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            height: 140,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColors.mainMenu2),
            padding: const EdgeInsets.all(30),
            child: SvgPicture.asset(
              AppImages.present,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 39),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Theme(
              data: Theme.of(context).copyWith(
                  inputDecorationTheme: const InputDecorationTheme(
                fillColor: null,
                filled: false,
              )),
              child: Form(
                key: state.formKeyPIN,
                child: PinPut(
                  onChanged: (value) {
                    if (value.length < 6) {
                      logic.checkAccountContinue();
                    }
                  },
                  onSubmit: (text) {
                    logic.checkAccountRequest();
                  },
                  textStyle: headline4,
                  focusNode: state.pinPutFocusNode,
                  controller: state.pinPutController,
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
          ),
          const Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ValueListenableBuilder<bool>(
                valueListenable: state.checkAccountContinue,
                builder: (BuildContext context, value, Widget? child) {
                  return ButtonFill(
                    voidCallback: value ? () {
                      state.agreePolicy = false;
                      Get.toNamed(RouteConfig.sign_form);
                    } : null,
                    title: S.of(context).continue_step,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20)
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
