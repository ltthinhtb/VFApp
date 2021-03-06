import 'package:get/get.dart';
import 'package:vf_app/model/entities/index.dart';
import 'package:vf_app/model/params/data_params.dart';
import 'package:vf_app/model/params/index.dart';
import 'package:vf_app/networks/error_exception.dart';
import 'package:vf_app/services/index.dart';
import 'package:vf_app/ui/commons/app_snackbar.dart';
import 'package:vf_app/utils/logger.dart';

import 'user_state.dart';

class UserLogic extends GetxController {
  final UserState state = UserState();
  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();

  late TokenEntity _tokenEntity;

  final RequestParams _requestParams = RequestParams(group: "B");

  Future<void> getTokenUser() async {
    try {
      _tokenEntity = (await authService.getToken())!;
      _requestParams.user = _tokenEntity.data?.user;
      _requestParams.session = _tokenEntity.data?.sid;
      await getListAccount();
    } catch (e) {
      logger.e(e.toString());
      await getTokenUser();
    }
  }

  Future<void> getListAccount() async {
    ParamsObject _object = ParamsObject();
    _object.type = "cursor";
    _object.cmd = "ListAccount";
    _requestParams.data = _object;
    try {
      var response = await apiService.getListAccount(_requestParams);
      if (response!.isNotEmpty) {
        state.listAccount = response;
      }
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    }
  }

  @override
  Future<void> onReady() async {
    await getTokenUser();

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
