import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/router/route_config.dart';
import 'package:vf_app/ui/pages/splash/widget/splash_content.dart';
import 'package:vf_app/ui/widgets/button/button_filled.dart';

import 'splash_logic.dart';
import 'splash_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashLogic logic = Get.put(SplashLogic());
  final SplashState state = Get.find<SplashLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 84),
            Container(
              alignment: Alignment.center,
              height: 70,
              width: 160,
              decoration: BoxDecoration(
                color: AppColors.grayC4,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                'Logo',
                style: headline4,
              ),
            ),
            const SizedBox(height: 84),
            Expanded(
              child: Obx(() {
                return PageView.builder(
                  onPageChanged: (value) {
                    logic.changeSplash(value);
                  },
                  itemCount: state.splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    image: state.splashData[index]["image"]!,
                    subtitle: state.splashData[index]["subtitle"]!,
                    title: state.splashData[index]["title"]!,
                  ),
                );
              }),
            ),
            Center(
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(state.splashData.length,
                      (int index) {
                    return buildDot(index: index);
                  }),
                );
              }),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonFill(
                      voidCallback: () {}, title: S.of(context).sign_up)),
            ),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  Get.toNamed(RouteConfig.login);
                },
                child: Text(S.of(context).have_account)),
            const SizedBox(height: 37),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      width: state.currentPage.value == index ? 21 : 10,
      decoration: BoxDecoration(
          color: state.currentPage.value == index
              ? Theme.of(context).primaryColor
              : Theme.of(context).dividerColor,
          borderRadius: BorderRadius.circular(5)),
    );
  }

  @override
  void dispose() {
    Get.delete<SplashLogic>();
    super.dispose();
  }
}
