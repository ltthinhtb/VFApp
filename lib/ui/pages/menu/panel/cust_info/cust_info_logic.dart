import 'package:get/get.dart';
import 'package:vf_app/model/entities/index.dart';
import 'package:vf_app/model/params/data_params.dart';
import 'package:vf_app/model/params/index.dart';
import 'package:vf_app/services/index.dart';
import 'package:vf_app/ui/pages/menu/panel/cust_info/cust_info_state.dart';

class CustomInfoLogic extends GetxController {
  CustomInfoState state = CustomInfoState();
  final ApiService _apiService = Get.find();
  final AuthService _authService = Get.find();

  late TokenEntity _tokenEntity;

  Future<void> initToken() async {
    try {
      _tokenEntity = (await _authService.getToken())!;
    } catch (e) {
      return initToken();
    }
  }

  Future<void> getCustomInfo() async {
    try {
      final RequestParams _requestParams = RequestParams(
        group: "B",
        session: _tokenEntity.data?.sid,
        user: _tokenEntity.data?.user,
        data: ParamsObject(
          type: "object",
          cmd: "APP.GET_CURRENT_ACCOUNT",
          p: AccountCodeObject(accountCode: _tokenEntity.data?.user),
        ),
      );
      state.accountInfo = await _apiService.getAccountInfo(_requestParams);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onInit() async {
    await initToken();
    await getCustomInfo();
    // TODO: implement onInit
    super.onInit();
  }
}
