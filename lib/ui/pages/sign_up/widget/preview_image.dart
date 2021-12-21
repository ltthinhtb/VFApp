import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vf_app/ui/pages/sign_up/enum/camera_enum.dart';
import '../sign_up_logic.dart';

class PreviewImage extends StatefulWidget {
  final CameraTake cameraTake;

  const PreviewImage({Key? key, required this.cameraTake}) : super(key: key);

  @override
  State<PreviewImage> createState() => _PreviewImageState();
}

class _PreviewImageState extends State<PreviewImage> {
  final logic = Get.find<SignUpLogic>();
  final state = Get.find<SignUpLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.memory(file.readAsBytesSync())),
    );
  }

  File get file {
    switch (widget.cameraTake) {
      case CameraTake.front:
        return state.cmndFront;
      case CameraTake.back:
        return state.cmndBack;
      case CameraTake.face:
        return state.face;
    }
  }
}
