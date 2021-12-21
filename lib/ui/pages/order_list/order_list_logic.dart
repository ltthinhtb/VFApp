import 'package:get/get.dart';
import 'package:vf_app/model/entities/index.dart';
import 'package:vf_app/model/params/data_params.dart';
import 'package:vf_app/model/params/index.dart';
import 'package:vf_app/services/api/api_service.dart';
import 'package:vf_app/services/index.dart';
import 'package:vf_app/ui/pages/order_list/order_list_state.dart';


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

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await initToken();
    getOrderList();
  }
}
