import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vf_app/router/route_config.dart';
import 'package:vf_app/ui/widgets/button/button_filled.dart';

class OpenSuccessAccount extends StatelessWidget {
  const OpenSuccessAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text("Cảm ơn bạn"),
          const Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ButtonFill(
              voidCallback: () {
                Get.offNamed(RouteConfig.splash);
              },
              title: "Hoàn tất",
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
