import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/ui/widgets/button/button_filled.dart';
import '../sign_up_logic.dart';

class SignaturePage extends StatefulWidget {
  const SignaturePage({Key? key}) : super(key: key);

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    // TODO: implement initState
    super.initState();
  }

  final logic = Get.find<SignUpLogic>();
  final state = Get.find<SignUpLogic>().state;

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;

    return WillPopScope(
      onWillPop: () async {
        await SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Quý khách vui lòng chạm vào khung bên dưới và giữ để ký',
                style: headline6!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(15),
                    color: AppColors.grayC4,
                    dashPattern: [10],
                    child: Stack(
                      children: [
                        Signature(
                          controller: state.signController,
                          width: MediaQuery.of(context).size.width,
                          backgroundColor: AppColors.white,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: SizedBox(
                              width: 70,
                              child: ButtonFill(
                                title: "Xóa",
                                voidCallback: () {
                                  state.signController.clear();
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitDown,
                        DeviceOrientation.portraitUp
                      ]);
                      Get.back();
                    },
                    child: Text(
                      S.of(context).cancel,
                      style: headline6.copyWith(
                          color: AppColors.gray88, fontWeight: FontWeight.w700),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      var bytes = await state.signController.toPngBytes();
                      await logic.uploadSignature(bytes!);
                    },
                    child: Text(
                      S.of(context).agree,
                      style: headline6.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
