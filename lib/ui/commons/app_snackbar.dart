import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/generated/l10n.dart';

class AppSnackBar {
  static void showInfo({String? title, String? message}) {
    Get.snackbar(
      title ?? "Info",
      message ?? "Empty message",
      backgroundColor: AppColors.primary,
      colorText: AppColors.white,
    );
  }

  static void showWarning({String? title, String? message}) {
    Get.snackbar(
      title ?? "Warning",
      message ?? "Empty message",
      backgroundColor: Colors.amber,
      colorText: Colors.white,
    );
  }

  static void showError({String? title, String? message}) {
    Get.snackbar(
      title ?? S.current.error,
      message ?? "Empty message",
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
