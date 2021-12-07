import 'package:get/get.dart';
import 'package:vf_app/common/app_images.dart';
import 'package:vf_app/generated/l10n.dart';

class SplashState {
  final currentPage = 0.obs;

  final RxList<Map<String, String>> splashData = [
    {
      "title": S.current.splash_title1,
      "subtitle": S.current.splash_sub1,
      "image": AppImages.splash1
    },
    {
      "title": S.current.splash_title2,
      "subtitle": S.current.splash_sub2,
      "image": AppImages.splash2
    },
    {
      "title": S.current.splash_title3,
      "subtitle": S.current.splash_sub3,
      "image": AppImages.splash3
    },
  ].obs;

  SplashState() {
    ///Initialize variables
  }
}
