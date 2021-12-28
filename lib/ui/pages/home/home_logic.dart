import 'package:get/get.dart';
import 'package:vf_app/model/response/index_detail.dart';
import 'package:vf_app/services/index.dart';
import 'package:vf_app/services/socket/socket.dart';
import 'package:vf_app/ui/commons/app_snackbar.dart';
import 'package:vf_app/ui/pages/enum/vnIndex.dart';
import 'package:vf_app/utils/logger.dart';
import 'home_state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();
  final Socket _socket = Socket();

  Future<void> getListIndexDetail() async {
    String list = "";
    Index.values.forEach((e) {
      if (e == Index.values.first) {
        list = e.code;
      } else {
        list += ',${e.code}';
      }
    });
    try {
      state.listIndexDetail.value = await apiService.getListIndexDetail(list);
    } catch (e) {
      AppSnackBar.showError(message: e.toString());
    }
  }

  Future<void> getListStockCode() async {
    String market = state.market.value;
    try {
      final response = await apiService.getListStockCode(market);
      String list = "";
      response.split(",").forEach((element) {
        if (element == response.split(",").first) {
          list = element;
        } else {
          list += ',$element';
        }
      });
      state.listStock.value = await apiService.getStockData(list);
    } catch (e) {
      AppSnackBar.showError(message: e.toString());
    }
  }

  void getIndexFromSocket() {
    _socket.socket.on('public', (data) {
      if (data != null) {
        try {
          IndexDetail stock = IndexDetail.fromJson(data['data']);
          var index = state.listIndexDetail
              .indexWhere((element) => element.mc == stock.mc);
          if (index >= 0) {
            state.listIndexDetail.removeAt(index);
            state.listIndexDetail.insert(index, stock);
          }
        } catch (e) {
          logger.e(e.toString());
        }
      }
    });
  }

  @override
  void onReady() {
    getListIndexDetail();
    getListStockCode();
    getIndexFromSocket();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
