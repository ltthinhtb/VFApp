import 'package:get/get.dart';
import 'package:vf_app/model/entities/index.dart';
import 'package:vf_app/services/index.dart';
import 'package:vf_app/ui/pages/menu/menu_state.dart';

class MenuLogic extends GetxController {
  final MenuState state = MenuState();
  final ApiService apiService = Get.find();
  final AuthService authService = Get.find();
  late TokenEntity _tokenEntity;

  void initToken() async {
    try {
      _tokenEntity = (await authService.getToken())!;
      state
        ..name.value = _tokenEntity.data!.name!
        ..acc.value = _tokenEntity.data!.user!;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initToken();
  }
}
