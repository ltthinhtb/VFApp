import 'dart:async';

import 'package:get/get.dart';
import 'package:vf_app/model/entities/index.dart';
import 'package:vf_app/model/order_data/change_order_data.dart';
import 'package:vf_app/model/order_data/inday_order.dart';
import 'package:vf_app/model/params/data_params.dart';
import 'package:vf_app/model/params/index.dart';
import 'package:vf_app/services/api/api_service.dart';
import 'package:vf_app/services/index.dart';
import 'package:vf_app/ui/pages/order_list/order_list_state.dart';
import 'package:vf_app/utils/extension.dart';

class OrderListLogic extends GetxController {
  final OrderListState state = OrderListState();
  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();
  late Timer _timer;

  late TokenEntity _tokenEntity;
  String get defAcc => _tokenEntity.data!.defaultAcc!;

  Future<void> initToken() async {
    try {
      _tokenEntity = (await authService.getToken())!;
    } catch (e) {
      return initToken();
    }
  }

  void startListener() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      final r = await checkList();
      if (r != null) {
        state.newDataArrived.value = true;
        state.listOrderStorage.value = r;
      }
      return;
    });
  }

  void getNewData() {
    state.newDataArrived.value = false;
    state.listOrder = state.listOrderStorage;
    return;
  }

  void getOrderList() async {
    final RequestParams _requestParams = RequestParams(
      group: "Q",
      session: _tokenEntity.data?.sid,
      user: _tokenEntity.data?.user,
      data: ParamsObject(
          type: "string",
          cmd: "Web.Order.IndayOrder2",
          p1: "1",
          p2: "30",
          p3: _tokenEntity.data?.defaultAcc,
          p4: "${state.symbol},${state.orderStatus},${state.orderType}"),
    );
    try {
      state.listOrder.value = await apiService.getIndayOrder(_requestParams);
    } catch (e) {
      print(e);
    }
  }

  Future<List<IndayOrder>?> checkList() async {
    final RequestParams _requestParams = RequestParams(
      group: "Q",
      session: _tokenEntity.data?.sid,
      user: _tokenEntity.data?.user,
      data: ParamsObject(
          type: "string",
          cmd: "Web.Order.IndayOrder2",
          p1: "1",
          p2: "30",
          p3: _tokenEntity.data?.defaultAcc,
          p4: "${state.symbol},${state.orderStatus},${state.orderType}"),
    );
    try {
      var listOrders = await apiService.getIndayOrder(_requestParams);
      if (listOrders.isNotEmpty) {
        if (listOrders.length == state.listOrder.length) {
          for (var i = 0; i < listOrders.length; i++) {
            if (listOrders[i].orderNo != state.listOrder[i].orderNo) {
              return listOrders;
            }
            if (listOrders[i].status != state.listOrder[i].status) {
              return listOrders;
            }
            return null;
          }
        } else {
          return listOrders;
        }
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> selectAll() async {
    state.selectedListOrder.clear();
    for (var item in state.listOrder) {
      if (item.canFix) {
        state.selectedListOrder.add(item);
      }
    }
  }

  Future<void> cancelOrder() async {
    if (state.selectedListOrder.isNotEmpty) {
      RequestParams _requestParams = RequestParams(
        group: "O",
        session: _tokenEntity.data?.sid,
        user: _tokenEntity.data?.user,
        data: ParamsObject(
          type: "string",
          cmd: "Web.cancelOrder",
          orderNo: "",
          fisID: "",
          orderType: "1",
          pin: "123456",
        ),
      );
      try {
        for (var item in state.selectedListOrder) {
          _requestParams.data!.orderNo = item.orderNo;
          await apiService.cancleOrder(_requestParams);
        }
      } catch (e) {
        rethrow;
      }
    }
    getOrderList();
  }

  Future<void> changeOrder(IndayOrder data, ChangeOrderData changeData) async {
    RequestParams _requestParams = RequestParams(
      group: "O",
      session: _tokenEntity.data?.sid,
      user: _tokenEntity.data?.user,
      data: ParamsObject(
        type: "string",
        cmd: "Web.changeOrder",
        orderNo: data.orderNo,
        nvol: int.tryParse(changeData.vol) ?? 0,
        nprice: changeData.price,
        fisID: "",
        orderType: "1",
        pin: "",
      ),
    );
    try {
      await apiService.changeOrder(_requestParams);
    } catch (e) {
      rethrow;
    }
  }

  bool itemIsChecked(String no) {
    if (state.selectedListOrder.any((element) => element.orderNo == no)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getListAccount() async {
    state.listAccount.clear();
    state.listAccount.add("T???t c???");
    state.account.value = state.listAccount[0];
    final RequestParams _requestParams = RequestParams(
      group: "B",
      session: _tokenEntity.data?.sid,
      user: _tokenEntity.data?.user,
    );
    ParamsObject _object = ParamsObject();
    _object.type = "cursor";
    _object.cmd = "ListAccount";
    _requestParams.data = _object;
    try {
      var response = await apiService.getListAccount(_requestParams);
      if (response != null) {
        response.forEach((e) => state.listAccount.add(e.accCode ?? "-"));
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<List<IndayOrder>> filterOrder() async {
    List<IndayOrder> filtedList = state.listOrder;
    switch (state.orderType.value) {
      case "T???t c???":
        break;
      case "Mua":
        filtedList.removeWhere((element) => element.side == "S");
        break;
      case "B??n":
        filtedList.removeWhere((element) => element.side == "B");
        break;
      default:
    }
    return filtedList;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await initToken();
    await getListAccount();
    getOrderList();
    startListener();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    _timer.cancel();
    super.onClose();
  }
}
