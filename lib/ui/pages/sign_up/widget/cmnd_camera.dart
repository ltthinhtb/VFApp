import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CmndCamera extends StatelessWidget {
  final CameraController controller;

  const CmndCamera({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: Clip(), child: _cameraPreview());
  }

  Widget _cameraPreview() {
    if (controller.value.isInitialized) {
      return Container(
        child: CameraPreview(controller),
      );
    } else {
      return const Text("Nodata");
    }
  }
}

class Paint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Colors.grey.withOpacity(0.8), BlendMode.dstOut);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class Clip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    print(size);
    Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(10, size.height / 2 - 230, size.width - 20, 260),
          const Radius.circular(10)));
    return path;
  }

  @override
  bool shouldReclip(oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
