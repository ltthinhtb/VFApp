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

  late TokenEntity _tokenEntity;
  String get defAcc => _tokenEntity.data!.defaultAcc!;

  Future<void> initToken() async {
    try {
      _tokenEntity = (await authService.getToken())!;
    } catch (e) {
      return initToken();
    }
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
    state.listOrder.value = await apiService.getIndayOrder(_requestParams);
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
        pin: "123456",
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
    state.listAccount.add("Tất cả");
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

  List<IndayOrder> filterOrder() {
    List<IndayOrder> filtedList = state.listOrder;
    switch (state.orderType.value) {
      case "Tất cả":
        break;
      case "Mua":
        filtedList.removeWhere((element) => element.side == "S");
        break;
      case "Bán":
        filtedList.removeWhere((element) => element.side == "B");
        break;
      default:
    }

    // switch (state.orderStatus.value) {
    //   case "Tất cả":
    //     break;
    //   case "Chờ khớp":
    //     filtedList.removeWhere((element) => element.side == "S");
    //     break;
    //   case "Bán":
    //     filtedList.removeWhere((element) => element.side == "B");
    //     break;
    //   default:
    // }

    return filtedList;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await initToken();
    await getListAccount();
    getOrderList();
  }
}
