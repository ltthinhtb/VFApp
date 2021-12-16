import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vf_app/common/app_text_styles.dart';
import 'package:vf_app/ui/commons/appbar.dart';
import 'package:vf_app/utils/stock_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../stock_order_logic.dart';

class StockOrderConfirm extends StatefulWidget {
  StockOrderConfirm({
    Key? key,
  }) : super(key: key);

  @override
  _StockOrderConfirmState createState() => _StockOrderConfirmState();
}

class _StockOrderConfirmState extends State<StockOrderConfirm> {
  final state = Get.find<StockOrderLogic>().state;

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(
        title: "Xác nhận lệnh mua",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            buildInfo("Số tài khoản", state.selectedCashBalance.value.accCode!),
            buildInfo("Loại lệnh", state.isBuy.value ? "Mua" : "Bán"),
            buildInfo("Mã CK", state.selectedStockInfo.value.sym!),
            buildInfo("Giá", state.price.value.toString()),
            buildInfo(
              "Khối lượng",
              StockUtil.formatVol(
                double.parse(state.vol.value.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: AppTextStyle.caption2,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: AppTextStyle.bodyText2,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
