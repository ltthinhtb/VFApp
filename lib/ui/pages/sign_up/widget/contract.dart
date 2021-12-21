import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/router/route_config.dart';
import 'package:vf_app/ui/widgets/button/button_filled.dart';

class Contract extends StatelessWidget {
  const Contract({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headline5 = Theme.of(context).textTheme.headline5;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(S.of(context).profile_info, style: headline5),
          const SizedBox(height: 30),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ButtonFill(
              title: S.of(context).register,
              voidCallback: () {
                Get.toNamed(RouteConfig.sign_up_signature);
              },
            ),
          )
        ],
      ),
    );
  }
}
