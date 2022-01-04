import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vf_app/model/entities/category_stock.dart';
import 'package:vf_app/model/response/index_detail.dart';
import 'package:vf_app/model/stock_data/stock_data.dart';

class HomeState {
  static const CATEGORY_DEFAULT = "HSX30";

  final listIndexDetail = <IndexDetail>[].obs;
  final categoryController = TextEditingController();
  var category_default = CategoryStock(title: CATEGORY_DEFAULT, stocks: []);
  final listStock = <StockData>[].obs;

  Rx<CategoryStock> category =
      CategoryStock(title: CATEGORY_DEFAULT, stocks: []).obs;

  RxList<CategoryStock> listCategory = <CategoryStock>[].obs;
}
