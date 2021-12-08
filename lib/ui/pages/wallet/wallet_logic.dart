import 'package:get/get.dart';
import 'package:vf_app/model/entities/index.dart';
import 'package:vf_app/model/params/data_params.dart';
import 'package:vf_app/model/params/index.dart';
import 'package:vf_app/networks/error_exception.dart';
import 'package:vf_app/router/route_config.dart';
import 'package:vf_app/services/index.dart';
import 'package:vf_app/ui/commons/app_snackbar.dart';
import 'package:vf_app/utils/logger.dart';
import 'wallet_state.dart';

class WalletLogic extends GetxController {
  final WalletState state = WalletState();
  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();

  late TokenEntity _tokenEntity;

  final RequestParams _requestParams = RequestParams(group: "Q");

  Future<void> getTokenUser() async {
    try {
      if (await authService.getToken() != null) {
        _tokenEntity = (await authService.getToken())!;
        _requestParams.user = _tokenEntity.data?.user;
        _requestParams.session = _tokenEntity.data?.sid;
        await getAccountStatus();
      } else {
        throw (Exception);
      }
    } catch (e) {
      logger.e(e.toString());
      await Get.offNamed(RouteConfig.login);
    }
  }

  Future<void> getAccountStatus() async {
    ParamsObject _object = ParamsObject();
    _object.type = "String";
    _object.cmd = "Web.Portfolio.AccountStatus";
    _object.p1 = "8888881";
    _requestParams.data = _object;
    try {
      await apiService.getAccountStatus(_requestParams);
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    }
  }

  @override
  void onReady() {
    // getTokenUser();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
