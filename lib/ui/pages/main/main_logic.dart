import 'package:get/get.dart';
import 'package:vf_app/model/stock_company_data/stock_company_data.dart';

import 'main_state.dart';

class MainLogic extends GetxController {
  final MainState state = MainState();

  void switchTap(int index) {
    state.selectedIndex.value = index;
  }

  void pushToOrderPage(StockCompanyData data, bool isBuy) {
    switchTap(2);
    state.stockOrderPage
      ..selectedStock = data
      ..isBuy = isBuy;
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
