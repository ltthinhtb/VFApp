//
import 'package:get/get.dart';
import 'package:vf_app/services/api/api_service.dart';
import 'package:vf_app/ui/pages/stock_order/stock_order_state.dart';

class StockOrderLogic extends GetxController {
  final StockOrderState state = StockOrderState();
  ApiService apiService = Get.find();

  

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
