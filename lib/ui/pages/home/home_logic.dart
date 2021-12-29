import 'dart:convert';
import 'package:get/get.dart';
import 'package:vf_app/model/response/index_detail.dart';
import 'package:vf_app/model/stock_data/stock_socket.dart';
import 'package:vf_app/services/index.dart';
import 'package:vf_app/services/socket/socket.dart';
import 'package:vf_app/ui/commons/app_snackbar.dart';
import 'package:vf_app/ui/pages/enum/vnIndex.dart';
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

        /// thêm vào socket
        addStockSocket(element);
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
          int index = -1;
          if (data['data']['id'] == 1101) {
            IndexDetail stock = IndexDetail.fromJson(data['data']);
            index = state.listIndexDetail
                .indexWhere((element) => element.mc == stock.mc);
            if (index >= 0) {
              state.listIndexDetail.removeAt(index);
              state.listIndexDetail.insert(index, stock);
            }
          } else if (data['data']['id'] == 3220) {
            SocketStock stock = SocketStock.fromJson(data['data']);
            var index = state.listStock
                .indexWhere((element) => element.sym == stock.sym);
            if (index >= 0) {
              var stockIndex = state.listStock[index].copyWith(stock);
              state.listStock.removeAt(index);
              state.listStock.insert(index, stockIndex);
            }
          }
        } catch (e) {
          //logger.e(e.toString());
        }
      }
    });
  }

  void addStockSocket(String stock) {
    var map = {"action": "join", "data": "$stock"};
    var msg = json.encode(map);
    _socket.socket.emit("regs", msg);
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
