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
import 'package:vf_app/ui/pages/sign_up/enum/camera_enum.dart';
import 'package:vf_app/ui/pages/sign_up/image_utils/image_crop.dart';
import 'package:vf_app/ui/pages/sign_up/widget/contract.dart';
import 'package:vf_app/ui/pages/sign_up/widget/orc_info.dart';
import 'package:vf_app/ui/pages/sign_up/widget/preview_camera.dart';
import 'package:vf_app/ui/pages/sign_up/widget/cmnd_check.dart';
import 'package:vf_app/ui/pages/sign_up/widget/ekyc_stepper.dart';
import 'package:vf_app/ui/pages/sign_up/widget/preview_image.dart';
import 'package:vf_app/ui/widgets/button/button_filled.dart';
import '../sign_up_logic.dart';

class TakePhotoPage extends StatefulWidget {
  const TakePhotoPage({Key? key}) : super(key: key);

  @override
  _TakePhotoPageState createState() => _TakePhotoPageState();
}

class _TakePhotoPageState extends State<TakePhotoPage> {
  late CameraController _controller;


  final logic = Get.find<SignUpLogic>();
  final state = Get.find<SignUpLogic>().state;

  final ValueNotifier<int> _stepperValue = ValueNotifier<int>(1);
  final ValueNotifier<bool> _isPreview = ValueNotifier<bool>(false);
  final ValueNotifier<CameraTake> _cameraTake =
      ValueNotifier<CameraTake>(CameraTake.front);

  late CameraDescription camera;

  bool checkFace = false;

  FaceDetector faceDetector = GoogleMlKit.vision.faceDetector(
      const FaceDetectorOptions(
          enableContours: true, enableClassification: true));

  bool isBusy = false;

  Future<void> _processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    final faces = await faceDetector.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      if (faces.length == 1) {
        checkFace = true;
      } else {
        checkFace = false;
      }
    }
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();
    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());
    final imageRotation =
        InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.Rotation_0deg;
    final inputImageFormat =
        InputImageFormatMethods.fromRawValue(image.format.raw) ??
            InputImageFormat.NV21;
    final planeData = image.planes.map((plane) {
      return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width);
    }).toList();
    final inputImageData = InputImageData(
        size: imageSize,
        imageRotation: imageRotation,
        inputImageFormat: inputImageFormat,
        planeData: planeData);
    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
    await _processImage(inputImage);
  }

  @override
  void initState() {
    super.initState();
    camera = state.cameras.first;
    _initCameraController(camera);
  }

  void _initCameraController(CameraDescription cameraDescription) {
    _controller = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      if (camera == state.cameras[1]) {
        _controller.startImageStream(_processCameraImage);
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
                Visibility(
                    visible: !isPreview,
                    child: PreviewCamera(
                      controller: _controller,
                      cameraTake: _cameraTake.value,
                      checkFace: checkFace,
                    )),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      EkycStepper(
                        stepperValue: _stepperValue,
                        isPreview: isPreview,
                      ),
                      ValueListenableBuilder(
                          valueListenable: _stepperValue,
                          builder: (context, index, child) {
                            if (index == 1) {
                              return cameraContent(_isPreview.value);
                            } else if (index == 2) {
                              return OrcInfo(
                                stepperValue: _stepperValue,
                              );
                            } else {
                              return const Contract();
                            }
                          }),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Column cameraContent(bool isPreview) {
    final headline4 = Theme.of(context).textTheme.headline4;
    return Column(
      children: [
        const SizedBox(height: 18),
        ValueListenableBuilder<CameraTake>(
            valueListenable: _cameraTake,
            builder: (context, value, child) {
              return Text(
                value.content,
                style: headline4!.copyWith(
                    color: isPreview ? AppColors.black : AppColors.white),
              );
            }),
        isPreview
            ? PreviewImage(
                cameraTake: _cameraTake.value,
              )
            : const SizedBox(
                height: 295,
              ),
        Visibility(
          visible: _cameraTake.value != CameraTake.face,
          child: CmndCheck(stepperValue: _stepperValue, isPreview: isPreview),
        ),
        Visibility(
          visible: _cameraTake.value == CameraTake.face && !_isPreview.value,
          child: const SizedBox(height: 200),
        ),
        const SizedBox(height: 30),
        isPreview
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                        child: ButtonFill(
                            type: ButtonEnums.cancel,
                            voidCallback: () async {
                              switch (_cameraTake.value) {
                                case CameraTake.front:
                                  await cmndFrontReTake();
                                  break;
                                case CameraTake.back:
                                  await cmndBackReTake();
                                  break;
                                case CameraTake.face:
                                  await faceReTake();
                                  break;
                              }
                            },
                            title: S.of(context).take_photo_again)),
                    const SizedBox(width: 16),
                    Expanded(
                        child: ButtonFill(
                            voidCallback: state.nextStep
                                ? () {
                                    switch (_cameraTake.value) {
                                      case CameraTake.front:
                                        nextCameraFront();
                                        break;
                                      case CameraTake.back:
                                        nextCameraBack();
                                        break;
                                      case CameraTake.face:
                                        nextCameraFace();
                                        break;
                                    }
                                  }
                                : null,
                            title: S.of(context).use_photo))
                  ],
                ),
              )
            : GestureDetector(
                onTap: () async {
                  switch (_cameraTake.value) {
                    case CameraTake.front:
                      await cmndFrontTake();
                      break;
                    case CameraTake.back:
                      await cmndBackTake();
                      break;
                    case CameraTake.face:
                      if (checkFace) {
                        await faceTake();
                      }
                      break;
                  }
                },
                child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle),
                    child: SvgPicture.asset(AppImages.camera)),
              ),
      ],
    );
  }

  Future<void> cmndFrontReTake() async {
    state.nextStep = false;
    await _controller.resumePreview();
    await state.cmndFront.delete();
    _isPreview.value = false;
  }

  Future<void> cmndBackReTake() async {
    state.nextStep = false;
    await _controller.resumePreview();
    await state.cmndBack.delete();
    _isPreview.value = false;
  }

  Future<void> faceReTake() async {
    state.nextStep = false;
    await _controller.resumePreview();
    await state.face.delete();
    await _controller.startImageStream(_processCameraImage);
    _isPreview.value = false;
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
    await logic.getImageUploadUrl(file, 'anhCmtSau');
    _isPreview.value = true;
  }

  Future<void> faceTake() async {
    await _controller.setFlashMode(FlashMode.off);
    final image = await _controller.takePicture();
    var file = File(image.path);
    await _controller.pausePreview();
    await _controller.stopImageStream();
    state.face = await ImageUtils.cropOval(file);
    await logic.getImageUploadUrl(file, 'anhTrucDien');
    _isPreview.value = true;
  }

  void nextCameraFront() {
    _cameraTake.value = CameraTake.back;
    state.nextStep = false;
    _controller.resumePreview();
    _isPreview.value = false;
  }

  void nextCameraBack() {
    _cameraTake.value = CameraTake.face;
    state.nextStep = false;
    switchFrontCamera();
    _controller.resumePreview();
    _isPreview.value = false;
  }

  void nextCameraFace() {
    _stepperValue.value = 2;
  }

  void switchFrontCamera() {
    if (state.cameras.length > 1) {
      camera = state.cameras[1];
      _initCameraController(camera);
    }
  }
}
