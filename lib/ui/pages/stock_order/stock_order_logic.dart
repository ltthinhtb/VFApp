//
import 'package:get/get.dart';
import 'package:vf_app/model/entities/index.dart';
import 'package:vf_app/model/params/data_params.dart';
import 'package:vf_app/model/params/index.dart';
import 'package:vf_app/model/stock_company_data/stock_company_data.dart';
import 'package:vf_app/services/api/api_service.dart';
import 'package:vf_app/services/index.dart';
import 'package:vf_app/ui/commons/app_snackbar.dart';
import 'package:vf_app/ui/pages/stock_order/stock_order_state.dart';
import 'package:vf_app/utils/order_utils.dart';

class StockOrderLogic extends GetxController {
  final StockOrderState state = StockOrderState();
  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();

  late TokenEntity _tokenEntity;
  String get defAcc => _tokenEntity.data!.defaultAcc!;

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

  Future<void> getStockInfo(StockCompanyData data, {String? account}) async {
    state.selectedStock.value = data;

    try {
      state.loading.value = true;
      final RequestParams _requestParams = RequestParams(
        group: "Q",
        session: _tokenEntity.data?.sid,
        user: _tokenEntity.data?.user,
        data: ParamsObject(
          type: "string",
          cmd: "Web.sStockInfo",
          p1: account ?? defAcc,
          p2: data.stockCode,
        ),
      );
      state.selectedStockInfo.value =
          await apiService.getStockInfo(_requestParams);
      state
        ..sumBuyVol.value = getSumBuyVol()
        ..sumSellVol.value = getSumSellVol()
        ..sumBSVol.value = getSumBSVol()
        ..stockExchange.value = getStockExchange()
        ..priceType.value = "MP"
        ..price.value = state.selectedStockInfo.value.lastPrice!.toString();
      await getAccountStatus(account);
      await getCashBalance();
      state.loading.value = false;
    } catch (error) {
      state.loading.value = false;
      AppSnackBar.showError(message: error.toString());
    }
  }

  Future<void> getAccountStatus(String? account) async {
    try {
      state.loading.value = true;
      final RequestParams _requestParams = RequestParams(
        group: "Q",
        session: _tokenEntity.data?.sid,
        user: _tokenEntity.data?.user,
        data: ParamsObject(
          type: "string",
          cmd: "Web.Portfolio.AccountStatus",
          p1: account ?? defAcc,
        ),
      );
      state.accountStatus.value =
          await apiService.getAccountMStatus(_requestParams);
      state.loading.value = false;
    } catch (error) {
      state.loading.value = false;
      AppSnackBar.showError(message: error.toString());
    }
  }

  Future<void> getCashBalance() async {
    try {
      state.loading.value = true;
      final RequestParams _requestParams = RequestParams(
        group: "Q",
        session: _tokenEntity.data?.sid,
        user: _tokenEntity.data?.user,
        data: ParamsObject(
            type: "string",
            cmd: "Web.sCashBalance",
            p1: defAcc,
            p2: state.selectedStock.value.stockCode,
            p3: state.priceController.text,
            p4: state.isBuy.value ? "B" : "S"),
      );
      state.selectedCashBalance.value =
          await apiService.getCashBalance(_requestParams);
      state.loading.value = false;
    } catch (e) {
      state.loading.value = false;
      rethrow;
    }
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
      ..price.value = state.selectedStockData.value.lastPrice!.toString();
  }

  Future requestNewOrder() async {
    String refId = _tokenEntity.data!.user! + ".M." + OrderUtils.getRandom();
    String sReceiveCheckSumValue = OrderUtils.generateMd5(
        _tokenEntity.data!.sid! +
            state.priceController.text +
            (state.isBuy.value ? "B" : "S") +
            state.volController.text +
            "vpbs@456" +
            _tokenEntity.data!.defaultAcc! +
            state.selectedStock.value.stockCode! +
            refId);
    final RequestParams _requestParams = RequestParams(
      group: "O",
      session: _tokenEntity.data?.sid,
      user: _tokenEntity.data?.user,
      checksum: sReceiveCheckSumValue,
      data: ParamsObject(
        type: "string",
        cmd: "Web.newOrder",
        account: _tokenEntity.data!.defaultAcc!,
        side: (state.isBuy.value ? "B" : "S"),
        symbol: state.selectedStock.value.stockCode!,
        volume: int.parse(state.volController.text),
        price: state.priceController.text,
        advance: "",
        refId: refId,
        orderType: "1",
        pin: state.pin.value,
      ),
    );
    try {
      await apiService.newOrderRequest(_requestParams);
      AppSnackBar.showSuccess(message: "Đặt lệnh thành công!");
    } catch (error) {
      AppSnackBar.showError(message: error.toString());
    }
  }

  void changePrice() {}

  void initToken() async {
    try {
      _tokenEntity = (await authService.getToken())!;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initToken();
    getAllStockCompanyData();
    printChecksum();
  }

  void printChecksum() {
    String refId = "200998.M." + OrderUtils.getRandom();
    print(refId);
    String sReceiveCheckSumValue = "acfdde1c-1c82-49bb-9120-92ef59cd7825" +
        "MP" +
        "B" +
        "1000" +
        "vpbs@456" +
        "2009986" +
        "AAA" +
        refId;
    print(OrderUtils.generateMd5(sReceiveCheckSumValue));
  }

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

  String getChangePc() {
    try {
      var per = double.parse(state.selectedStockInfo.value.ot!) /
          state.selectedStockInfo.value.r!;
      return per.toStringAsFixed(2) + "%";
    } catch (e) {
      return "0.0%";
    }
  }

  double getSumBuyVol() {
    num _sum = state.selectedStockInfo.value.g1!.volumn! +
        state.selectedStockInfo.value.g2!.volumn! +
        state.selectedStockInfo.value.g3!.volumn!;
    return _sum.toDouble();
  }

  double getSumSellVol() {
    num _sum = state.selectedStockInfo.value.g4!.volumn! +
        state.selectedStockInfo.value.g5!.volumn! +
        state.selectedStockInfo.value.g6!.volumn!;
    return _sum.toDouble();
  }

  double getSumBSVol() {
    num _sum = state.selectedStockInfo.value.g1!.volumn! +
        state.selectedStockInfo.value.g2!.volumn! +
        state.selectedStockInfo.value.g3!.volumn! +
        state.selectedStockInfo.value.g4!.volumn! +
        state.selectedStockInfo.value.g5!.volumn! +
        state.selectedStockInfo.value.g6!.volumn!;
    return _sum.toDouble();
  }
}
