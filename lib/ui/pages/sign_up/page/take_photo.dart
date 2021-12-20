import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/common/app_images.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/ui/commons/appbar.dart';
import 'package:vf_app/ui/pages/sign_up/image_utils/image_crop.dart';
import 'package:vf_app/ui/pages/sign_up/widget/cmnd_camera.dart';
import 'package:vf_app/ui/pages/sign_up/widget/cmnd_check.dart';
import 'package:vf_app/ui/pages/sign_up/widget/ekyc_stepper.dart';
import 'package:vf_app/ui/widgets/button/button_filled.dart';

import '../sign_up_logic.dart';

class TakePhotoPage extends StatefulWidget {
  const TakePhotoPage({Key? key}) : super(key: key);

  @override
  _TakePhotoPageState createState() => _TakePhotoPageState();
}

class _TakePhotoPageState extends State<TakePhotoPage> {
  late CameraController _controller;

  TextDetector textDetector = GoogleMlKit.vision.textDetector();

  final logic = Get.find<SignUpLogic>();
  final state = Get.find<SignUpLogic>().state;

  final ValueNotifier<int> _stepperValue = ValueNotifier<int>(1);
  final ValueNotifier<bool> _isPreview = ValueNotifier<bool>(false);

  final ValueNotifier<String> _contentCamera =
      ValueNotifier<String>('Mặt trước CMND/CCCD');

  bool isCmndFrontTake = true;

  @override
  void initState() {
    final firstCamera = state.cameras.first;
    super.initState();
    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final headline4 = Theme.of(context).textTheme.headline4;
    return ValueListenableBuilder<bool>(
        valueListenable: _isPreview,
        builder: (context, isPreview, child) {
          return Scaffold(
            backgroundColor: isPreview
                ? AppColors.white
                : const Color(0xff3B3B3B).withOpacity(0.6),
            appBar: AppBarCustom(
              title: S.of(context).take_photo_confirm,
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      EkycStepper(
                        stepperValue: _stepperValue,
                        isPreview: isPreview,
                      ),
                      const SizedBox(height: 18),
                      ValueListenableBuilder<String>(
                          valueListenable: _contentCamera,
                          builder: (context, text, child) {
                            return Text(
                              text,
                              style: headline4!.copyWith(
                                  color: isPreview
                                      ? AppColors.black
                                      : AppColors.white),
                            );
                          }),
                      isPreview
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.memory(
                                      state.cmndFront.readAsBytesSync())),
                            )
                          : const SizedBox(
                              height: 295,
                            ),
                      CmndCheck(
                          stepperValue: _stepperValue, isPreview: isPreview),
                      const SizedBox(height: 30),
                      isPreview
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: ButtonFill(
                                          type: ButtonEnums.cancel,
                                          voidCallback: () async {
                                            if (_stepperValue.value == 1) {
                                              if (isCmndFrontTake) {
                                                await cmndFrontReTake();
                                              } else {
                                                await cmndBackReTake();
                                              }
                                            }
                                          },
                                          title:
                                              S.of(context).take_photo_again)),
                                  const SizedBox(width: 16),
                                  Expanded(
                                      child: ButtonFill(
                                          voidCallback: state.nextStep
                                              ? () {
                                                  if (_stepperValue.value ==
                                                      1) {
                                                    if (isCmndFrontTake) {
                                                      nextStep11();
                                                    } else {}
                                                  }
                                                }
                                              : null,
                                          title: S.of(context).use_photo))
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                await cmndFrontTake();
                              },
                              child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      shape: BoxShape.circle),
                                  child: SvgPicture.asset(AppImages.camera)),
                            ),
                    ],
                  ),
                ),
                Visibility(
                    visible: !isPreview,
                    child: CmndCamera(controller: _controller)),
              ],
            ),
          );
        });
  }

  Future<void> cmndFrontReTake() async {
    _isPreview.value = false;
    state.nextStep = false;
    await _controller.resumePreview();
    await state.cmndFront.delete();
  }

  Future<void> cmndBackReTake() async {
    _isPreview.value = false;
    state.nextStep = false;
    await _controller.resumePreview();
    await state.cmndBack.delete();
  }

  Future<void> cmndFrontTake() async {
    final image = await _controller.takePicture();
    var file = File(image.path);
    await _controller.pausePreview();
    state.cmndFront = await ImageUtils.cropImage(file);
    await logic.getImageUploadUrl(file, 'anhCmtTruoc');
    _isPreview.value = true;
  }

  Future<void> cmndBackTake() async {
    final image = await _controller.takePicture();
    var file = File(image.path);
    await _controller.pausePreview();
    state.cmndBack = await ImageUtils.cropImage(file);
    _isPreview.value = true;
  }

  void nextStep11() {
    isCmndFrontTake = false;
    _controller.resumePreview();
    _contentCamera.value = "Mặt sau CMND/CCCD";
    _isPreview.value = false;
  }
}
