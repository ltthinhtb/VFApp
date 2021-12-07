import 'package:flutter/material.dart';

class StockOrderState {
  late TextEditingController stockCodeController;

  StockOrderState({String? stockCode}) {
    stockCodeController = TextEditingController(text: stockCode ?? 'APS');
  }
}
