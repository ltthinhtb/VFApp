import 'package:get/get.dart';
import 'package:vf_app/model/order_data/inday_order.dart';

class OrderListState {
  // late TextEditingController stockCodeController;
  // List<StockCompanyData> allStockCompanyData = <StockCompanyData>[];

  var loading = false.obs;
  var selectedMode = false.obs;

  var selectedListOrder = <IndayOrder>[].obs;

  var listOrder = <IndayOrder>[].obs;

  var isBuy = true.obs;
  var account = "ALL".obs;
  var symbol = "".obs;
  var orderType = "ALL".obs;
  var orderStatus = "Tất cả".obs;

  OrderListState() {
    // stockCodeController = TextEditingController(text: stockCode ?? 'APS');
  }
}
