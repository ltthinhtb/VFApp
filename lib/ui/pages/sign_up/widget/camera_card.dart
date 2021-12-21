import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.1523669, size.height * 0.008298755);
    path_0.lineTo(size.width * 0.03402367, size.height * 0.008298755);
    path_0.cubicTo(
        size.width * 0.01768388,
        size.height * 0.008298755,
        size.width * 0.004437870,
        size.height * 0.02687614,
        size.width * 0.004437870,
        size.height * 0.04979253);
    path_0.lineTo(size.width * 0.004437870, size.height * 0.2157676);

    Paint paint_0_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.008875740;
    paint_0_stroke.color = Colors.white.withOpacity(1.0);
    paint_0_stroke.strokeCap = StrokeCap.round;
    canvas.drawPath(path_0, paint_0_stroke);

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = const Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.1523669, size.height * 0.9917012);
    path_1.lineTo(size.width * 0.03402367, size.height * 0.9917012);
    path_1.cubicTo(
        size.width * 0.01768388,
        size.height * 0.9917012,
        size.width * 0.004437870,
        size.height * 0.9731245,
        size.width * 0.004437870,
        size.height * 0.9502075);
    path_1.lineTo(size.width * 0.004437870, size.height * 0.7842324);

    Paint paint_1_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.008875740;
    paint_1_stroke.color = Colors.white.withOpacity(1.0);
    paint_1_stroke.strokeCap = StrokeCap.round;
    canvas.drawPath(path_1, paint_1_stroke);

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = const Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.8476331, size.height * 0.008298755);
    path_2.lineTo(size.width * 0.9659763, size.height * 0.008298755);
    path_2.cubicTo(
        size.width * 0.9823166,
        size.height * 0.008298755,
        size.width * 0.9955621,
        size.height * 0.02687614,
        size.width * 0.9955621,
        size.height * 0.04979253);
    path_2.lineTo(size.width * 0.9955621, size.height * 0.2157676);

    Paint paint_2_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.008875740;
    paint_2_stroke.color = Colors.white.withOpacity(1.0);
    paint_2_stroke.strokeCap = StrokeCap.round;
    canvas.drawPath(path_2, paint_2_stroke);

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = const Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.8476331, size.height * 0.9917012);
    path_3.lineTo(size.width * 0.9659763, size.height * 0.9917012);
    path_3.cubicTo(
        size.width * 0.9823166,
        size.height * 0.9917012,
        size.width * 0.9955621,
        size.height * 0.9731245,
        size.width * 0.9955621,
        size.height * 0.9502075);
    path_3.lineTo(size.width * 0.9955621, size.height * 0.7842324);

    Paint paint_3_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.008875740;
    paint_3_stroke.color = Colors.white.withOpacity(1.0);
    paint_3_stroke.strokeCap = StrokeCap.round;
    canvas.drawPath(path_3, paint_3_stroke);

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = const Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_3, paint_3_fill);

    Paint paint_4_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    paint_4_stroke.color = Colors.white.withOpacity(1.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(size.width * 0.03550296, size.height * 0.05186722,
                size.width * 0.9289941, size.height * 0.8962656),
            bottomRight: Radius.circular(size.width * 0.02810651),
            bottomLeft: Radius.circular(size.width * 0.02810651),
            topLeft: Radius.circular(size.width * 0.02810651),
            topRight: Radius.circular(size.width * 0.02810651)),
        paint_4_stroke);

    Paint paint_4_fill = Paint()..style = PaintingStyle.fill;
    paint_4_fill.color = Colors.white.withOpacity(1.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(size.width * 0.03550296, size.height * 0.05186722,
                size.width * 0.9289941, size.height * 0.8962656),
            bottomRight: Radius.circular(size.width * 0.02810651),
            bottomLeft: Radius.circular(size.width * 0.02810651),
            topLeft: Radius.circular(size.width * 0.02810651),
            topRight: Radius.circular(size.width * 0.02810651)),
        paint_4_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
