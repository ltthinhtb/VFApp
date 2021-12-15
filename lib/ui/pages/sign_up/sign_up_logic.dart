import 'package:get/get.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/model/params/check_account_request.dart';
import 'package:vf_app/networks/error_exception.dart';
import 'package:vf_app/router/route_config.dart';
import 'package:vf_app/services/auth_service.dart';
import 'package:vf_app/services/index.dart';
import 'package:vf_app/ui/commons/app_snackbar.dart';
import 'package:vf_app/utils/logger.dart';
import 'package:vf_app/utils/validator.dart';

import 'sign_up_state.dart';

class SignUpLogic extends GetxController with Validator {
  final SignUpState state = SignUpState();
  ApiService apiService = Get.find();
  AuthService authService = Get.find();

  Future<void> checkAccountRequest() async {
    CheckAccountRequest request = CheckAccountRequest(
        cmd: 'CHECK_CUSTID',
        user: 'back',
        param: Param(cCUSTOMERCODE: state.pinPutController.text));
    try {
      await apiService.checkAccountStatus(request);
      checkAccountContinue(statusAccount: true);
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    } catch (e) {
      logger.e(e.runtimeType);
    }
  }

  void checkAccountContinue({bool? statusAccount}) {
    if (statusAccount == null) {
      state.checkAccountContinue.value = false;
    } else if (state.pinPutController.text.length == 6 && statusAccount) {
      state.checkAccountContinue.value = true;
    } else {
      state.checkAccountContinue.value = false;
    }
  }

  Future<void> checkPhoneEmail() async {
    CheckAccountRequest request = CheckAccountRequest(
        cmd: 'CHECK_OPENACC',
        user: 'back',
        param: Param(
          cEMAIL: state.emailNameController.text,
          cMOBILE: state.phoneNameController.text,
        ));
    bool validateFullName = state.formFullName.currentState!.validate();
    bool validatePhoneName = state.formPhone.currentState!.validate();
    bool validateEmail = state.formEmail.currentState!.validate();
    bool validatePass = state.formPass.currentState!.validate();
    if (!validateFullName) {
      AppSnackBar.showError(
          message: checkFullName(state.fullNameController.text));
    } else if (!validatePhoneName) {
      AppSnackBar.showError(
          message: checkPhoneNumber(state.phoneNameController.text));
    } else if (!validateEmail) {
      AppSnackBar.showError(
          message: checkEmail(state.emailNameController.text));
    } else if (!validatePass) {
      AppSnackBar.showError(message: checkPass(state.passController.text));
    } else if (!state.agreePolicy) {
      AppSnackBar.showError(message: S.current.terms_and_condition_valid);
    } else {
      try {
        await apiService.checkAccountStatus(request);
        await Get.toNamed(RouteConfig.sign_up_otp);
      } on ErrorException catch (error) {
        AppSnackBar.showError(message: error.message);
      } catch (e) {
        logger.e(e.runtimeType);
      }
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
