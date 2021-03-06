import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/common/app_text_styles.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/ui/widgets/button/button_text.dart';

import 'app_loading.dart';

class AppDiaLog {
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

  static Future<void> showNoticeDialog(
      {String? title, String? middleText, VoidCallback? onConfirm}) async {
    AppLoading.disMissLoading();
    await Get.defaultDialog(
        title: title ?? "Thông báo",
        middleText: middleText ?? " ",
        titleStyle: AppTextStyle.H3.copyWith(fontSize: 18),
        middleTextStyle: AppTextStyle.bodyText1,
        barrierDismissible: false,
        confirm: ButtonText(
          title: "OK",
          voidCallback: onConfirm ??
              () {
                Get.back();
              },
        ));
  }

  static Future<void> showConfirmDialog(
      {String? title, String? middleText, VoidCallback? onConfirm}) async {
    AppLoading.disMissLoading();
    await Get.defaultDialog(
        title: title ?? S.current.notice,
        middleText: middleText ?? " ",
        titleStyle: AppTextStyle.H3.copyWith(fontSize: 18),
        middleTextStyle: AppTextStyle.bodyText1,
        barrierDismissible: false,
        textConfirm: "Xác nhận",
        textCancel: "Hủy",
        buttonColor: AppColors.primary,
        cancelTextColor: AppColors.primary,
        confirmTextColor: AppColors.white,
        onConfirm: onConfirm);
  }
}
