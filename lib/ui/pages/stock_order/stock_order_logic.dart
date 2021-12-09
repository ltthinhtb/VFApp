//
import 'package:get/get.dart';
import 'package:vf_app/model/stock_company_data/stock_company_data.dart';
import 'package:vf_app/model/stock_data/stock_data.dart';
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
    state.allStockCompanyData = await apiService.getAllStockCompanyData();
  }

  void getStockData(StockCompanyData data) async {
    // print("getStockData");
    state.selectedStock.value = data;
    state.selectedStockData.value =
        await apiService.getStockData(data.stockCode!);
    print(state.selectedStockData.value.sym);
    state
      ..sumBuyVol.value = getSumBuyVol(state.selectedStockData.value)
      ..sumSellVol.value = getSumSellVol(state.selectedStockData.value)
      ..sumBSVol.value = getSumBSVol(state.selectedStockData.value);
  }

  double getSumBuyVol(StockData data) {
    num _sum = data.g1!.volumn! + data.g2!.volumn! + data.g3!.volumn!;
    // print('_sum $_sum');
    return _sum.toDouble();
  }

  double getSumSellVol(StockData data) {
    num _sum = data.g4!.volumn! + data.g5!.volumn! + data.g6!.volumn!;
    return _sum.toDouble();
  }

  double getSumBSVol(StockData data) {
    num _sum = data.g1!.volumn! +
        data.g2!.volumn! +
        data.g3!.volumn! +
        data.g4!.volumn! +
        data.g5!.volumn! +
        data.g6!.volumn!;
    return _sum.toDouble();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllStockCompanyData();
  }
}
