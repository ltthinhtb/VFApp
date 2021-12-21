import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:vf_app/ui/pages/sign_up/enum/camera_enum.dart';

class PreviewCamera extends StatefulWidget {
  final CameraController controller;
  final CameraTake cameraTake;
  final bool checkFace;

  const PreviewCamera(
      {Key? key,
      required this.controller,
      required this.cameraTake,
      required this.checkFace})
      : super(key: key);

  @override
  State<PreviewCamera> createState() => _PreviewCameraState();
}

class _PreviewCameraState extends State<PreviewCamera> {
  @override
  Widget build(BuildContext context) {
    return _clipCamera;
  }

  Widget get _clipCamera {
    switch (widget.cameraTake) {
      case CameraTake.front:
        return ClipPath(clipper: ClipRect(), child: _cameraPreview());
      case CameraTake.back:
        return ClipPath(clipper: ClipRect(), child: _cameraPreview());
      case CameraTake.face:
        return Stack(
          children: [
            Visibility(
              visible: widget.checkFace,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Align(
                  alignment: Alignment.center,
                  child: CustomPaint(
                    painter: RPSCustomPainter(),
                    size: const Size(414, 736),
                  ),
                ),
              ),
            ),
            ClipPath(
                clipper: ClipOval(widget.checkFace), child: _cameraPreview()),

          ],
        );
    }
  }

  Widget _cameraPreview() {
    if (widget.controller.value.isInitialized) {
      return Container(
        child: CameraPreview(widget.controller),
      );
    } else {
      return const Text("Nodata");
    }
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Colors.green.withOpacity(1.0);
    final Offset center = Offset(size.width / 2, size.height / 2 + 20);
    canvas.drawOval(
        Rect.fromCenter(
            center: center, width: size.width - 16, height: size.height - 246),
        paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ClipRect extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(10, size.height / 2 - 230, size.width - 20, 260),
          const Radius.circular(10)));
    return path;
  }

  @override
  bool shouldReclip(oldClipper) {
    return true;
  }
}

class ClipOval extends CustomClipper<Path> {
  final bool checkFace;

  ClipOval(this.checkFace);

  @override
  Path getClip(Size size) {
    print(size);
    final Offset center = Offset(size.width / 2, size.height / 2 + 20);
    Path path = Path()
      ..addOval(Rect.fromCenter(
          center: center, width: size.width - 20, height: size.height - 250));
    return path;
  }

  @override
  bool shouldReclip(oldClipper) {
    return true;
  }
}
