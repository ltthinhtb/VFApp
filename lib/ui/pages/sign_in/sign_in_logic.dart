import 'package:get/get.dart';
import 'package:vf_app/model/params/data_params.dart';
import 'package:vf_app/model/params/index.dart';
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

  final RequestParams _requestParams = RequestParams(
    group: "L",
    session: "",
    channel: "channel",
  );

  void signIn() async {
    AppLoading.showLoading();
    final username = state.usernameTextController.text;
    final password = state.passwordTextController.text;
    bool validateUser = state.formKeyUser.currentState!.validate();
    bool validatePass = state.formKeyPass.currentState!.validate();
    bool validate = validateUser && validatePass;
    if (validate) {
      var dataParam = ParamsObject(
          cmd: 'Web.sCheckLogin',
          type: "string",
          p1: username,
          p2: password,
          p3: "M");
      _requestParams.user = username;
      _requestParams.data = dataParam;
      try {
        final result = await apiService.signIn(_requestParams);
        if (result != null) {
          authService.saveToken(result);
          AppLoading.disMissLoading();
          await Get.offAllNamed(RouteConfig.main);
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
