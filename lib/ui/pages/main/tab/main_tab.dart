import 'package:flutter/cupertino.dart';
import 'package:vf_app/common/app_images.dart';
import 'package:vf_app/generated/l10n.dart';

enum MainTab {
  home,
  product,
  assets,
  history,
  profile,
}

extension MainTabExtension on MainTab {
  String label(BuildContext context) {
    switch (this) {
      case MainTab.home:
        return S.of(context).home;
      case MainTab.product:
        return S.of(context).product;
      case MainTab.assets:
        return S.of(context).assets;
      case MainTab.history:
        return S.of(context).history;
      case MainTab.profile:
        return S.of(context).user;
    }
  }

  String get iconYellow {
    switch (this) {
      case MainTab.home:
        return AppImages.eye_lock;
      case MainTab.product:
        return AppImages.eye_lock;
      case MainTab.assets:
        return AppImages.eye_lock;
      case MainTab.history:
        return AppImages.eye_lock;
      case MainTab.profile:
        return AppImages.eye_lock;
    }
  }

  String get iconGrey {
    switch (this) {
      case MainTab.home:
        return AppImages.eye_lock;
      case MainTab.product:
        return AppImages.eye_lock;
      case MainTab.assets:
        return AppImages.eye_lock;
      case MainTab.history:
        return AppImages.eye_lock;
      case MainTab.profile:
        return AppImages.eye_lock;
    }
  }
}
