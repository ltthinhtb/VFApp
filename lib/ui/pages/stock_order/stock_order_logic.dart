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
import 'package:vf_app/utils/extension.dart';
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
    if (state.selectedStock.value.stockCode == null) {
      await getStockInfo(state.allStockCompanyData
          .firstWhere((element) => element.stockCode == "AAA"));
    }
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
        ..priceController.text = "MP"
        ..price.value = state.selectedStockInfo.value.lastPrice!.toString();
      await getAccountStatus(account);
      await getCashBalance();
      state.loading.value = false;
    } catch (error) {
      state.loading.value = false;
      AppSnackBar.showError(message: error.toString());
    }
  }

  Future<void> refreshPage() async {
    try {
      final RequestParams _requestParams = RequestParams(
        group: "Q",
        session: _tokenEntity.data?.sid,
        user: _tokenEntity.data?.user,
        data: ParamsObject(
          type: "string",
          cmd: "Web.sStockInfo",
          p1: defAcc,
          p2: state.selectedStock.value.stockCode,
        ),
      );
      state.selectedStockInfo.value =
          await apiService.getStockInfo(_requestParams);
      state
        ..sumBuyVol.value = getSumBuyVol()
        ..sumSellVol.value = getSumSellVol()
        ..sumBSVol.value = getSumBSVol();
      await getAccountStatus(defAcc);
      await getCashBalance();
    } catch (error) {
      AppSnackBar.showError(message: error.toString());
    }
  }

  Future<void> getAccountStatus(String? account) async {
    try {
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
    } catch (error) {
      AppSnackBar.showError(message: error.toString());
    }
  }

  Future<void> getCashBalance() async {
    try {
      // state.loading.value = true;
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
      // state.loading.value = false;
    } catch (e) {
      // state.loading.value = false;
      rethrow;
    }
  }

  Future<void> getShareBalance() async {
    try {
      // state.loading.value = true;
      final RequestParams _requestParams = RequestParams(
        group: "Q",
        session: _tokenEntity.data?.sid,
        user: _tokenEntity.data?.user,
        data: ParamsObject(
            type: "string",
            cmd: "Web.sShareBalance",
            p1: defAcc,
            p2: state.selectedStock.value.stockCode,
            p3: state.priceController.text,
            p4: state.isBuy.value ? "B" : "S"),
      );
      state.selectedShareBalance.value =
          await apiService.getShareBalance(_requestParams);
      // state.loading.value = false;
    } catch (e) {
      // state.loading.value = false;
      rethrow;
    }
  }

  Future<void> getStockData(StockCompanyData data) async {
    state.selectedStock.value = data;
    // thêm try catch vào để bắt exception lỗi mạng hoặc data k đúng
    var list = await apiService.getStockData(data.stockCode!);
    if (list.isNotEmpty) {
      state.selectedStockData.value = list.first;
    }
    state
      ..sumBuyVol.value = getSumBuyVol()
      ..sumSellVol.value = getSumSellVol()
      ..sumBSVol.value = getSumBSVol()
      ..stockExchange.value = getStockExchange()
      ..priceType.value = "MP"
      ..price.value = state.selectedStockData.value.lastPrice!.toString();
  }

  Future<void> requestNewOrder() async {
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
        volume: int.tryParse(state.volController.text.replaceAll(",", "")),
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

  Future<void> initToken() async {
    try {
      _tokenEntity = (await authService.getToken())!;
    } catch (e) {
      return await initToken();
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await initToken();
    getAllStockCompanyData();
  }

  Future<void> validateInfo() async {
    if (state.selectedStock.value.stockCode == null) {
      throw 0;
    }
    if (state.priceController.text.isNotIn(priceType) &&
        state.priceController.text.isNotANumber) {
      throw -1;
    }
    if (state.volController.text.isNotANumber) {
      throw -2;
    }
    if (state.volController.text.isNotPositive) {
      throw -3;
    }
    if (state.volController.text.isNotAnInteger) {
      throw -4;
    }
    // if (state.volController.text.isNotPositive ||
    //     !state.volController.text.isMultipleOfHundred ||
    //     state.volController.text.isNotAnInteger) {
    //   throw -2;
    // }
    return;
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

List<String> priceType = [
  "LO",
  "MP",
  "ATC",
  "ATO",
  "MTL",
  "MOK",
  "MAK",
  "PLO",
];
