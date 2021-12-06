import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/common/app_images.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/router/route_config.dart';
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
    final TextStyle headline6 = Theme.of(context).textTheme.headline6!;

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
            Image.asset(
              AppImages.splash1,
              height: 196,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 40),
            Text(S.of(context).splash_title1,
                style:
                    headline4.copyWith(color: Theme.of(context).primaryColor)),
            const SizedBox(height: 10),
            Text(S.of(context).splash_sub1,
                style: headline6.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400)),
            const Spacer(),
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

  @override
  void dispose() {
    Get.delete<SplashLogic>();
    super.dispose();
  }
}
