import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/common/app_dimens.dart';
import 'package:vf_app/common/app_text_styles.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/networks/error_exception.dart';
import 'package:vf_app/services/index.dart';
import 'package:get/get.dart';
import 'package:vf_app/ui/commons/app_snackbar.dart';
import 'package:vf_app/ui/pages/menu/panel/setting/change_password_page/change_password_logic.dart';
import 'package:vf_app/ui/widgets/textfields/app_text_field.dart';

import 'change_password_state.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final ChangePasswordLogic logic = Get.put(ChangePasswordLogic());
  final ChangePasswordState state = Get.find<ChangePasswordLogic>().state;
  final SettingService settingService = Get.find<SettingService>();
  bool showButton = false;
  late Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startListener();
  }

  void startListener() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.old_controller.text.isNotEmpty &&
          state.new_controller.text.isNotEmpty &&
          state.confirm_controller.text.isNotEmpty) {
        setState(() {
          showButton = true;
        });
      } else {
        setState(() {
          showButton = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // void showButtonListener() async {
  //   while (true) {
  //     print(state.old_controller.text.isNotEmpty &&
  //         state.new_controller.text.isNotEmpty &&
  //         state.confirm_controller.text.isNotEmpty);
  //     if (state.old_controller.text.isNotEmpty &&
  //         state.new_controller.text.isNotEmpty &&
  //         state.confirm_controller.text.isNotEmpty) {
  //       setState(() {
  //         showButton = true;
  //       });
  //     } else {
  //       setState(() {
  //         showButton = false;
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Container(
          child: Text(
            S.of(context).change_password,
            style: AppTextStyle.H3,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(AppDimens.paddingNormal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildLanguageSection(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: showButton
          ? MaterialButton(
              minWidth: width - 30,
              height: 50,
              color: AppColors.primary,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              onPressed: () async {
                try {
                  await logic.validateInfo();
                  await logic.changePassword();
                  AppSnackBar.showSuccess(
                      message: S.of(context).change_password_success);
                } on ErrorException catch (e) {
                  AppSnackBar.showError(message: e.message);
                } catch (e) {
                  AppSnackBar.showError(message: e.toString());
                }
              },
              child: Text(
                S.of(context).save_password,
                style: AppTextStyle.H5Bold.copyWith(color: Colors.white),
              ),
            )
          : null,
    );
  }

  Widget _buildLanguageSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          // key: state.formKeyUser,
          child: AppTextFieldWidget(
            obscureText: true,
            inputController: state.old_controller,
            label: S.of(context).old_password,
            hintText: S.of(context).old_password,
          ),
        ),
        Form(
          // key: state.formKeyUser,
          child: AppTextFieldWidget(
            obscureText: true,
            inputController: state.new_controller,
            label: S.of(context).new_password,
            hintText: S.of(context).new_password,
          ),
        ),
        Form(
          // key: state.formKeyUser,
          child: AppTextFieldWidget(
            obscureText: true,
            inputController: state.confirm_controller,
            label: S.of(context).confirm_new_password,
            hintText: S.of(context).confirm_new_password,
          ),
        ),
      ],
    );
  }
}
