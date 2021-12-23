import 'package:get/get.dart';
import 'package:vf_app/model/response/index_detail.dart';
import 'package:vf_app/model/stock_data/stock_data.dart';

class HomeState {

   final listIndexDetail = <IndexDetail>[].obs;
   final market = "HNX30".obs;

   final listStock = <StockData>[].obs;

  HomeState() {
    ///Initialize variables
  }
}
