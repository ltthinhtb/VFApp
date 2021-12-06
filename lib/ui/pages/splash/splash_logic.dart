import 'package:vf_app/services/api/api_service.dart';
import 'package:vf_app/services/index.dart';
import 'package:get/get.dart';

import 'splash_state.dart';

class SplashLogic extends GetxController {
  final state = SplashState();
  final apiService = Get.find<ApiService>();
  final authService = Get.find<AuthService>();

  void initState() async {
    //await Future.delayed(const Duration(seconds: 2));
    authService.removeToken();
    //await Get.offAllNamed(RouteConfig.login);
  }
}
