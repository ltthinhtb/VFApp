import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vf_app/model/stock_company_data/stock_company_data.dart';

class StockOrderState {
  late TextEditingController stockCodeController;
  List<StockCompanyData> allStockCompanyData = <StockCompanyData>[];
  var foundStock = <StockCompanyData>[].obs;
  StockOrderState({String? stockCode}) {
    stockCodeController = TextEditingController(text: stockCode ?? 'APS');
  }
}
