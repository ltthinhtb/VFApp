import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/common/app_text_styles.dart';

class AppDialog {
  static void showDialog({String? title, String? middleText,Widget? content}) {
    Get.defaultDialog(
      radius: 15,
      title: title ?? "",
      middleText: middleText ?? "",
      titleStyle: AppTextStyle.H4Bold,
      middleTextStyle: AppTextStyle.H6Regular.copyWith(color: AppColors.black),
      content: content,
      contentPadding: EdgeInsets.zero,
    );
  }
}
