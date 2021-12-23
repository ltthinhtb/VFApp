import 'package:vf_app/ui/pages/main/main_logic.dart';
import 'package:vf_app/ui/pages/main/main_view.dart';
import 'package:vf_app/ui/pages/order_list/order_list_view.dart';
import 'package:vf_app/ui/pages/search/search_view.dart';

import 'package:vf_app/ui/pages/sign_in/sign_in_view.dart';
import 'package:vf_app/ui/pages/sign_up/page/sign_up_activated.dart';
import 'package:vf_app/ui/pages/sign_up/page/sign_up_form.dart';
import 'package:vf_app/ui/pages/sign_up/page/sign_up_otp.dart';
import 'package:vf_app/ui/pages/sign_up/page/signature.dart';
import 'package:vf_app/ui/pages/sign_up/page/success_open_account.dart';
import 'package:vf_app/ui/pages/sign_up/page/take_photo.dart';
import 'package:vf_app/ui/pages/sign_up/sign_up_view.dart';
import 'package:vf_app/ui/pages/splash/splash_view.dart';
import 'package:get/get.dart';

class RouteConfig {
  ///main page
  static const String splash = "/splash";
  static const String main = "/main";
  static const String login = "/login";
  static const String sign_up = '/sign_up';
  static const String sign_form = '/sign_up_form';
  static const String sign_up_otp = '/sign_up_otp';
  static const String sign_up_activated = "/sign_up_activated";
  static const String sign_up_photo = "/sign_up_photo";
  static const String sign_up_signature = "/sign_up_signature";
  static const String success_open_account = '/success_open_account';
  static const String invest = "/invest";
  static const String invest_confirm = '/invest_confirm';
  static const String search = "/search";
  static const String order_list = "/order_list";
  static const String order_detail = "/order_detail";

  ///Alias ​​mapping page
  static final List<GetPage> getPages = [
    GetPage(name: splash, page: () => const SplashPage()),
    GetPage(name: main, page: () => MainPage(), binding: MainBinding()),
    GetPage(name: login, page: () => const SignInPage()),
    GetPage(name: invest, page: () => MainPage()),
    GetPage(name: invest_confirm, page: () => MainPage()),
    GetPage(name: sign_up, page: () => const SignUpPage()),
    GetPage(name: sign_form, page: () => const SignUpFormPage()),
    GetPage(name: sign_up_otp, page: () => const SignUpOTPPage()),
    GetPage(name: sign_up_activated, page: () => const ActivatedPage()),
    GetPage(name: sign_up_photo, page: () => const TakePhotoPage()),
    GetPage(name: sign_up_signature, page: () => const SignaturePage()),
    GetPage(name: success_open_account, page: () => const OpenSuccessAccount()),
    GetPage(name: search, page: () => const SearchPage()),
    GetPage(name: order_list, page: () => OrderListPage()),
  ];
}

class MainBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => MainLogic());
  }
}
