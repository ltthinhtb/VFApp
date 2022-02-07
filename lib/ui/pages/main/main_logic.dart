import 'dart:io';

import 'package:get/get.dart';
import 'package:vf_app/model/stock_company_data/stock_company_data.dart';
import 'package:vf_app/networks/error_exception.dart';
import 'package:vf_app/services/index.dart';
import 'package:vf_app/services/notification_service.dart';
import 'package:vf_app/ui/commons/app_snackbar.dart';

import 'main_state.dart';

class MainLogic extends GetxController {
  final MainState state = MainState();
  final NotificationService notificationService =
      Get.find<NotificationService>();

  final ApiService apiService = Get.find();

  void switchTap(int index) {
    state.selectedIndex.value = index;
  }

  void pushToOrderPage(StockCompanyData data, bool isBuy) {
    switchTap(2);
    state.stockOrderPage
      ..selectedStock = data
      ..isBuy = isBuy;
  }

  Future<void> sendToken() async {
    try {
      var response = await apiService.sendToken({
        "cmd": "add",
        "account": Get.find<AuthService>().token.value!.data!.user,
        "token": Get.find<NotificationService>().token,
        "device": Platform.isAndroid ? "AND" : "IOS"
      });
      print(response['rs']);
    } on ErrorException catch (error) {
      AppSnackBar.showError(message: error.message);
    }
  }

  @override
  void onReady() {
    notificationService.fcmSubscribe("all");
    sendToken();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
