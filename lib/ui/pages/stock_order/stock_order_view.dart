import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vf_app/ui/pages/stock_order/stock_order_logic.dart';
import 'package:vf_app/ui/pages/stock_order/widget/stock_order_appbar.dart';

class StockOrderPage extends StatefulWidget {
  StockOrderPage({Key? key}) : super(key: key);

  @override
  _StockOrderPageState createState() => _StockOrderPageState();
}

class _StockOrderPageState extends State<StockOrderPage> {
  final logic = Get.put(StockOrderLogic());
  final state = Get.find<StockOrderLogic>().state;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StockOrderAppbar(
        onLeadingPress: () {},
      ),
      body: Container(),
    );
  }
}
