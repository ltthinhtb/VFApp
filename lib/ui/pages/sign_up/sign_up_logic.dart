import 'package:get/get.dart';
import 'package:vf_app/model/params/check_account_request.dart';
import 'package:vf_app/networks/error_exception.dart';
import 'package:vf_app/services/auth_service.dart';
import 'package:vf_app/services/index.dart';
import 'package:vf_app/ui/commons/app_snackbar.dart';
import 'package:vf_app/utils/logger.dart';

import 'sign_up_state.dart';

class SignUpLogic extends GetxController {
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
      AppSnackBar.showError(title: error.message);
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
