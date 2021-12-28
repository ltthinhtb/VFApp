import 'package:get/get.dart';
import 'package:vf_app/model/entities/index.dart';
import 'package:vf_app/model/params/data_params.dart';
import 'package:vf_app/model/params/index.dart';
import 'package:vf_app/services/index.dart';
import 'package:vf_app/ui/pages/menu/panel/setting/change_password_page/change_password_state.dart';

class ChangePasswordLogic extends GetxController {
  final ChangePasswordState state = ChangePasswordState();
  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();

  late TokenEntity _tokenEntity;

  Future<void> initToken() async {
    try {
      _tokenEntity = (await authService.getToken())!;
    } catch (e) {
      return initToken();
    }
  }

  Future<void> changePassword() async {
    print(ChangePasswordModel(state.old_controller.text,
            state.new_controller.text, state.confirm_controller.text)
        .toJson());
    final RequestParams _requestParams = RequestParams(
      group: "B",
      session: _tokenEntity.data?.sid,
      user: _tokenEntity.data?.user,
      data: ParamsObject(
        type: "object",
        cmd: "APP.CHANGE_PASSWORD",
        p: ChangePasswordModel(state.old_controller.text,
            state.new_controller.text, state.confirm_controller.text),
      ),
    );
    try {
      await apiService.changePassword(_requestParams);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> validateInfo() async {
    if (state.new_controller.text != state.confirm_controller.text) {
      throw "Xác nhận mật khẩu không khớp";
    } else {
      return;
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await initToken();
  }
}
