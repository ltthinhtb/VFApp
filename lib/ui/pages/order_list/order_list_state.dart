import 'package:get/get.dart';
import 'package:vf_app/model/order_data/inday_order.dart';

class OrderListState {
  // late TextEditingController stockCodeController;
  // List<StockCompanyData> allStockCompanyData = <StockCompanyData>[];

  var loading = false.obs;
  var selectedMode = false.obs;

  var selectedListOrder = <IndayOrder>[].obs;

  var listOrder = <IndayOrder>[].obs;
  var listAccount = <String>[];

  var isBuy = true.obs;
  var account = "".obs;
  var orderType = "".obs;
  var orderStatus = "".obs;
  var symbol = "".obs;

  OrderListState() {
    // stockCodeController = TextEditingController(text: stockCode ?? 'APS');
  }
}
