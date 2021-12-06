import 'package:get/get.dart';
import 'package:vf_app/networks/error_exception.dart';
import 'package:vf_app/router/route_config.dart';
import 'package:vf_app/services/api/api_service.dart';
import 'package:vf_app/services/auth_service.dart';
import 'package:vf_app/ui/commons/app_loading.dart';
import 'package:vf_app/ui/commons/app_snackbar.dart';
import 'package:vf_app/utils/validator.dart';

import 'sign_in_state.dart';

class SignInLogic extends GetxController with Validator {
  final SignInState state = SignInState();

  ApiService apiService = Get.find();
  AuthService authService = Get.find();

  void signIn() async {
    AppLoading.showLoading();
    final username = state.usernameTextController.text;
    final password = state.passwordTextController.text;
    bool validateUser = state.formKeyUser.currentState!.validate();
    bool validatePass = state.formKeyPass.currentState!.validate();
    bool validate = validateUser && validatePass;
    if (validate) {
      try {
        final result = await apiService.signIn(username, password);
        if (result != null) {
          authService.saveToken(result);
          AppLoading.disMissLoading();
          await Get.offNamed(RouteConfig.main);
        } else {
          signIn();
        }
      } on ErrorException catch (error) {
        AppSnackBar.showError(message: error.message);
      } on Exception {
        signIn();
      }
    }
    AppLoading.disMissLoading();
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
