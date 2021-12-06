import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'main_logic.dart';
import 'tab/main_tab.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final logic = Get.put(MainLogic());
  final state = Get.find<MainLogic>().state;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildPageView() {
    return Obx(() {
      return IndexedStack(
        index: state.selectedIndex.value,
        children: state.pageList,
      );
    });
  }

  Widget _buildBottomNavigationBar() {
    return Obx(() {
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: state.selectedIndex.value,
        elevation: 8,
        items: List<BottomNavigationBarItem>.generate(MainTab.values.length,
            (int index) {
          return BottomNavigationBarItem(
            icon: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: SvgPicture.asset(
                  MainTab.values[index].iconGrey,
                )),
            label: MainTab.values[index].label(context),
          );
        }),
        onTap: (index) {
          logic.switchTap(index);
        },
      );
    });
  }

  @override
  void dispose() {
    Get.delete<MainLogic>();
    super.dispose();
  }
}
