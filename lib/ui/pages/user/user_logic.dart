import 'package:get/get.dart';
import 'package:vf_app/model/entities/index.dart';
import 'package:vf_app/model/params/data_params.dart';
import 'package:vf_app/model/params/index.dart';
import 'package:vf_app/model/response/list_account_response.dart';
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
      if (await authService.getToken() != null) {
        _tokenEntity = (await authService.getToken())!;
        _requestParams.user = _tokenEntity.data?.user;
        _requestParams.session = _tokenEntity.data?.sid;
        await getListAccount();
      } else {
        throw (Exception);
      }
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
      if (response!.data!.isNotEmpty) {
        state.listAccount = response.data!;
        state.account.value = state.listAccount.firstWhere((element) => element.accCode == _tokenEntity.data!.defaultAcc!);
      }
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    }
  }

  void changeAccount(Account account){
    state.account.value = account;
  }

  @override
  Future<void> onReady() async {
    await getTokenUser();
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
