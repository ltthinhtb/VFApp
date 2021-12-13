import 'package:get/get.dart';
import 'package:vf_app/model/entities/index.dart';
import 'package:vf_app/model/params/data_params.dart';
import 'package:vf_app/model/params/index.dart';
import 'package:vf_app/networks/error_exception.dart';
import 'package:vf_app/services/index.dart';
import 'package:vf_app/ui/commons/app_snackbar.dart';
import 'package:vf_app/utils/logger.dart';
import 'wallet_state.dart';

class WalletLogic extends GetxController {
  final WalletState state = WalletState();
  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();

  late TokenEntity _tokenEntity;

  String get defAcc => _tokenEntity.data!.defaultAcc!;

  final RequestParams _requestParams = RequestParams(group: "Q");

  Future<void> getTokenUser() async {
    try {
      if (await authService.getToken() != null) {
        _tokenEntity = (await authService.getToken())!;
        _requestParams.user = _tokenEntity.data?.user;
        _requestParams.session = _tokenEntity.data?.sid;
        await getAccountStatus();
        await getPortfolio();
        await getPortfolioAccountStatus();
      } else {
        throw (Exception);
      }
    } catch (e) {
      logger.e(e.toString());
      await getTokenUser();
    }
  }

  Future<void> getAccountStatus({String? account}) async {
    ParamsObject _object = ParamsObject();
    _object.type = "String";
    _object.cmd = "Web.Portfolio.AccountStatus";
    _object.p1 = account ?? defAcc;
    _requestParams.data = _object;
    try {
      var response = await apiService.getAccountStatus(_requestParams);
      if (response!.data!.isNotEmpty) {
        state.assets.value = response.data!.first;
      }
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    }
  }

  Future<void> getPortfolioAccountStatus({String? account}) async {
    ParamsObject _object = ParamsObject();
    _object.type = "string";
    _object.cmd = "Web.Portfolio.AccountStatus";
    _object.p1 = account ?? defAcc;
    _requestParams.data = _object;
    try {
      var response = await apiService.getPortfolioAccountStatus(_requestParams);
      state.portfolioAccount.value = response!.data!;
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    }
  }

  Future<void> getPortfolio({String? account}) async {
    ParamsObject _object = ParamsObject();
    _object.type = "string";
    _object.cmd = "Web.Portfolio.PortfolioStatus";
    _object.p1 = account ?? defAcc;
    _requestParams.data = _object;
    try {
      var response = await apiService.getPortfolio(_requestParams);
      if (response!.data!.isNotEmpty) {
        state.portfolioTotal.value = response.data!.first;
        state.profitController.text = state.portfolioTotal.value.gainLossValue!;
        if (response.data!.length > 1) {
          state.portfolioList.value = response.data!;
          state.portfolioList.remove(state.portfolioList.first);
        }
      }
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    }
  }

  @override
  void onReady() {
    getTokenUser();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
