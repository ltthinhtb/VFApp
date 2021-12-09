import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vf_app/model/stock_company_data/stock_company_data.dart';
import 'package:vf_app/model/stock_data/stock_data.dart';

class StockOrderState {
  late TextEditingController stockCodeController;
  List<StockCompanyData> allStockCompanyData = <StockCompanyData>[];

  var foundStock = <StockCompanyData>[].obs;
  var selectedStock = StockCompanyData().obs;

  var isBuy = true.obs;
  var selectedStockData = StockData().obs;

  var sumBuyVol = 0.0.obs;
  var sumSellVol = 0.0.obs;
  var sumBSVol = 0.0.obs;

  StockOrderState({String? stockCode}) {
    stockCodeController = TextEditingController(text: stockCode ?? 'APS');
  }
}
