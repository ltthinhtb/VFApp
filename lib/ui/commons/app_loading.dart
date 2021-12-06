import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppLoading {
  static void showLoading() {
    EasyLoading.show(dismissOnTap: true);
  }

  static void disMissLoading() {
    EasyLoading.dismiss();
  }
}
