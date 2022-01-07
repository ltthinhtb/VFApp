import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vf_app/common/app_images.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/router/route_config.dart';
import 'package:vf_app/ui/widgets/button/button_filled.dart';

import '../sign_up_logic.dart';

class OpenSuccessAccount extends StatelessWidget {
  const OpenSuccessAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<SignUpLogic>().state;

    final headline6 = Theme.of(context).textTheme.headline6;
    final headline3 = Theme.of(context).textTheme.headline3;
    setOrientation();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Column(
        children: [
          RichText(
              text: TextSpan(children: [
            TextSpan(text: S.of(context).tks, style: headline6),
            TextSpan(
                text: ' ${state.identityCard.name ?? ""}',
                style: headline3!.copyWith(
                    fontSize: 15, color: Theme.of(context).primaryColor)),
          ])),
          const SizedBox(height: 10),
          RichText(
              text: TextSpan(children: [
            TextSpan(text: S.of(context).about_choose, style: headline6),
            TextSpan(
                text: ' VF TRADE',
                style: headline3.copyWith(
                    fontSize: 15, color: Theme.of(context).primaryColor)),
          ])),
          const SizedBox(height: 40),
          SvgPicture.asset(AppImages.like_big_size),
          const SizedBox(height: 29),
          Text(
            S.of(context).complete,
            style: headline3.copyWith(fontSize: 15),
          ),
          const SizedBox(height: 10),
          Text(
            S.of(context).active_account,
            style: headline6,
          ),
          const SizedBox(height: 47),
          Text(
            '${state.accountSuccess}',
            style: headline6,
          ),
          const SizedBox(height: 70),
          Text(
            S.of(context).waiting_few_minute,
            style: headline3.copyWith(fontSize: 15),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              S.of(context).success_title1,
              style: headline6!.copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              S.of(context).success_title2,
              textAlign: TextAlign.center,
              style: headline6,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ButtonFill(
                voidCallback: () {
                  Get.offNamedUntil(
                      RouteConfig.login, (Route<dynamic> route) => false);
                },
                title: "Hoàn tất",
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  Future<bool> setOrientation() async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return true;
  }
}
