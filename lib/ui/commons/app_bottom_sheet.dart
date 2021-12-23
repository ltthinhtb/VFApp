import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vf_app/common/app_colors.dart';

class AppBottomSheet {
  static void show(Widget bottomSheet) {
    Get.bottomSheet(bottomSheet,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),topRight: Radius.circular(15)
        )
    ));
  }
}
