//
import 'package:get/get.dart';
import 'package:vf_app/model/stock_company_data/stock_company_data.dart';
import 'package:vf_app/services/api/api_service.dart';
import 'package:vf_app/ui/pages/stock_order/stock_order_state.dart';

class StockOrderLogic extends GetxController {
  final StockOrderState state = StockOrderState();
  ApiService apiService = Get.find();

  List<StockCompanyData> searchStock(String stockCode) {
    if (stockCode != '') {
      List<StockCompanyData> searchResult = state.allStockCompanyData
          .where(
            (element) => element.stockCode!.toLowerCase().startsWith(
                  stockCode.toLowerCase(),
                ),
          )
          .toList();
      if (searchResult.length > 10) {
        searchResult = searchResult.sublist(0, 10);
      }
      return searchResult;
    } else {
      return [];
    }
  }

  void getAllStockCompanyData() async {
    // thêm try catch vào để bắt exception lỗi mạng hoặc data k đúng
    state.allStockCompanyData = await apiService.getAllStockCompanyData();
  }

  void getStockData(StockCompanyData data) async {
    print("getStockData");
    state.selectedStock.value = data;
    // thêm try catch vào để bắt exception lỗi mạng hoặc data k đúng
    state.selectedStockData.value =
        await apiService.getStockData(data.stockCode!);
    print(state.selectedStockData.value.sym);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllStockCompanyData();
  }
}
