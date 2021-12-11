import 'package:flutter/material.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/model/stock_data/stock_data.dart';
import 'package:vf_app/utils/logger.dart';
import 'package:intl/intl.dart';

class StockUtil {
  static Color itemColor(StockData data) {
    num change = data.lastPrice! - data.r!;
    if (change > 0) {
      return AppColors.increase;
    } else if (change < 0) {
      return AppColors.decrease;
    } else {
      return AppColors.yellow;
    }
  }

  static String valueSign(StockData data) {
    num change = data.lastPrice! - data.r!;
    if (change > 0) {
      return "+";
    } else if (change < 0) {
      return "-";
    } else {
      return "";
    }
  }

  static String formatVol10(num _number) {
    try {
      var numerators =
          NumberFormat("###,###,###,###,##", 'en_US').format(_number);
      return numerators;
    } catch (e) {
      logger.e(e.toString());
    }
    return '0';
  }

  static String formatVol(num _number) {
    try {
      var numerators =
          NumberFormat("###,###,###,###,###", 'en_US').format(_number);
      return numerators;
    } catch (e) {
      logger.e(e.toString());
    }
    return '0';
  }
}
