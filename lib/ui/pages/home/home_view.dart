import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vf_app/ui/widgets/textfields/app_text_field.dart';

import 'home_logic.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(HomeLogic());
    final state = Get.find<HomeLogic>().state;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: kToolbarHeight + 20,
        title: AppTextFieldWidget(
          //fillColor: const Color(0xff3D2676).withOpacity(0.6),
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
