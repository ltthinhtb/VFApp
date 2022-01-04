import 'dart:convert';
import 'package:get/get.dart';
import 'package:vf_app/model/entities/category_stock.dart';
import 'package:vf_app/model/response/index_detail.dart';
import 'package:vf_app/model/stock_data/stock_socket.dart';
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
  final StoreService storeService = Get.find();

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

  Future<void> getListStockCodeDefault() async {
    String market = HomeState.CATEGORY_DEFAULT;
    try {
      final response = await apiService.getListStockCode(market);
      state.category_default.stocks.addAll(response.split(","));
      state.listCategory = storeService.currentCategory;
      await selectCategory(state.category_default);
    } catch (e) {
      AppSnackBar.showError(message: e.toString());
    }
  }

  void socketListen() {
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
            logger.d(data);
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

  void removeStockSocket(String stock) {
    var map = {"action": "leave", "data": "$stock"};
    var msg = json.encode(map);
    _socket.socket.emit("regs", msg);
  }

  Future<void> addCategory() async {
    if (state.categoryController.text.isNotEmpty) {
      await storeService.addCategory(
          CategoryStock(title: state.categoryController.text, stocks: []));
      state.categoryController.clear();
      Get.back();
    }
  }

  Future<void> addStockDB(String stock) async {
    await storeService.addStock(state.category.value.title, stock);
    /// chọn lại category
    await selectCategory(state.category.value);
  }

  Future<void> deleteCategory(String title) async {
    await storeService.deleteCategory(title);
  }

  Future<void> editCategory(String title, String newTitle) async {
    await storeService.editCategory(title, newTitle);
    Get.back(); // đóng bottom sheet
  }

  Future<void> selectCategory(CategoryStock category) async {
    /// xóa stock socket cũ đi
    state.category.value.stocks.forEach((element) {
      removeStockSocket(element);
    });
    state.category.value = category;
    state.listStock.value =
        await apiService.getStockData(state.category.value.stocks.join(","));

    /// cập nhật stock socket mới
    state.category.value.stocks.forEach((element) {
      removeStockSocket(element);
    });
    Get.back(); // đóng bottom sheet
  }

  @override
  void onReady() {
    getListIndexDetail();
    getListStockCodeDefault();
    socketListen();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
