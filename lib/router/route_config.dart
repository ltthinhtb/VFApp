import 'package:vf_app/ui/pages/main/main_view.dart';

import 'package:vf_app/ui/pages/sign_in/sign_in_view.dart';
import 'package:vf_app/ui/pages/sign_up/page/sign_up_form.dart';
import 'package:vf_app/ui/pages/sign_up/page/sign_up_otp.dart';
import 'package:vf_app/ui/pages/sign_up/sign_up_view.dart';
import 'package:vf_app/ui/pages/splash/splash_view.dart';
import 'package:get/get.dart';

class RouteConfig {
  ///main page
  static final String splash = "/splash";
  static final String main = "/main";
  static final String login = "/login";
  static final String sign_up = '/sign_up';
  static final String sign_form = '/sign_up_form';
  static final String sign_up_otp = '/sign_up_otp';
  static final String invest = "/invest";
  static final String invest_confirm = '/invest_confirm';

  ///Alias ​​mapping page
  static final List<GetPage> getPages = [
    GetPage(name: splash, page: () => const SplashPage()),
    GetPage(name: main, page: () => const MainPage()),
    GetPage(name: login, page: () => const SignInPage()),
    GetPage(name: invest, page: () => const MainPage()),
    GetPage(name: invest_confirm, page: () => const MainPage()),
    GetPage(name: sign_up, page: () => const SignUpPage()),
    GetPage(name: sign_form, page: () => const SignUpFormPage()),
    GetPage(name: sign_up_otp, page: () => const SignUpOTPPage())
  ];
}
