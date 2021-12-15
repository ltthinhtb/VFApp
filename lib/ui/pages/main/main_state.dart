import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:vf_app/ui/pages/home/home_view.dart';
import 'package:vf_app/ui/pages/menu/menu_view.dart';
import 'package:vf_app/ui/pages/setting/setting_page.dart';
import 'package:vf_app/ui/pages/stock_order/stock_order_view.dart';
import 'package:vf_app/ui/pages/wallet/wallet_view.dart';

class MainState {
  late RxInt selectedIndex;

  ///PageView page
  late List<Widget> pageList;
  late PageController pageController;

  MainState() {
    //Initialize index
    selectedIndex = 0.obs;
    //PageView page
    pageList = [
      const HomePage(),
      const WalletPage(),
      StockOrderPage(),
      Container(color: Colors.green),
      Menu(),
    ];
    //Page controller
    pageController = PageController();
  }
}
