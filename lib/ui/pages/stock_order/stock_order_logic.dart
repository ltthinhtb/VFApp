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

  Future<void> getStockData(StockCompanyData data) async {
    state.selectedStock.value = data;
    // thêm try catch vào để bắt exception lỗi mạng hoặc data k đúng
    state.selectedStockData.value =
        await apiService.getStockData(data.stockCode!);
    state
      ..sumBuyVol.value = getSumBuyVol()
      ..sumSellVol.value = getSumSellVol()
      ..sumBSVol.value = getSumBSVol()
      ..stockExchange.value = getStockExchange()
      ..priceType.value = "MP"
      ..price.value = state.selectedStockData.value.lastPrice!.toDouble();
  }

  void changePrice() {}

  StockExchange getStockExchange() {
    switch (state.selectedStock.value.postTo) {
      case "HOSE":
        return StockExchange.HSX;
      case "HNX":
        return StockExchange.HNX;
      default:
        return StockExchange.UPCOM;
    }
  }

  double getSumBuyVol() {
    num _sum = state.selectedStockData.value.g1!.volumn! +
        state.selectedStockData.value.g2!.volumn! +
        state.selectedStockData.value.g3!.volumn!;
    return _sum.toDouble();
  }

  double getSumSellVol() {
    num _sum = state.selectedStockData.value.g4!.volumn! +
        state.selectedStockData.value.g5!.volumn! +
        state.selectedStockData.value.g6!.volumn!;
    return _sum.toDouble();
  }

  double getSumBSVol() {
    num _sum = state.selectedStockData.value.g1!.volumn! +
        state.selectedStockData.value.g2!.volumn! +
        state.selectedStockData.value.g3!.volumn! +
        state.selectedStockData.value.g4!.volumn! +
        state.selectedStockData.value.g5!.volumn! +
        state.selectedStockData.value.g6!.volumn!;
    return _sum.toDouble();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllStockCompanyData();
  }
}
