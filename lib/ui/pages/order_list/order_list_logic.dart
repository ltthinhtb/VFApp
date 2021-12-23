import 'package:get/get.dart';
import 'package:vf_app/model/entities/index.dart';
import 'package:vf_app/model/params/data_params.dart';
import 'package:vf_app/model/params/index.dart';
import 'package:vf_app/services/api/api_service.dart';
import 'package:vf_app/services/index.dart';
import 'package:vf_app/ui/pages/order_list/order_list_state.dart';
import 'package:vf_app/utils/error_message.dart';

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
      rethrow;
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
      if (MessageOrder.getStatusOrder(item) == "Khớp 1 phần" ||
          MessageOrder.getStatusOrder(item) == "Chờ khớp") {
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

  bool itemIsChecked(String no) {
    if (state.selectedListOrder.any((element) => element.orderNo == no)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await initToken();
    getOrderList();
  }
}
