import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/common/app_text_styles.dart';
import 'package:vf_app/utils/stock_utils.dart';

class PricePercentPainter extends CustomPainter {
  PricePercentPainter(
      {required this.color, this.value = 0, this.sum = 0, required this.isBuy});
  final Color color;
  final double value;
  final num sum;
  final bool isBuy;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    if (sum > 0) {
      Paint _paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      if (isBuy) {
        canvas.translate(size.width, size.height);
        canvas.rotate(pi);
      }
      canvas.save();

      Rect _rect = Rect.fromLTWH(0, 0, (value / sum) * size.width, size.height);
      RRect _rRect = RRect.fromRectAndRadius(_rect, const Radius.circular(5));

      canvas.drawRRect(_rRect, _paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate != this;
  }
}

class PricePercentRow extends StatefulWidget {
  PricePercentRow(
      {Key? key,
      required this.price,
      this.value = 0,
      required this.sum,
      this.color = AppColors.primary,
      this.isBuy = true,
      this.padding = 3})
      : super(key: key);
  final bool isBuy;
  final String price;
  final double value;
  final double sum;
  final Color color;
  final double padding;
  @override
  _PricePercentRowState createState() => _PricePercentRowState();
}

class _PricePercentRowState extends State<PricePercentRow>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('widget.value ${widget.value}');
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = Tween<double>(begin: 0.0, end: widget.value)
        .animate(_animationController)
      ..addStatusListener((status) {
        setState(() {});
      })
      ..addListener(() {
        setState(() {});
      });
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      print(widget.value > 0);
      if (widget.value > 0) {
        _animationController.forward();
        setState(() {});
      }
    });
  }

  void updateAnimation() {
    _animationController.reset();
    _animation = Tween<double>(begin: 0.0, end: widget.value)
        .animate(_animationController)
      ..addStatusListener((status) {
        setState(() {});
      })
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void didUpdateWidget(covariant PricePercentRow oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      updateAnimation();
      _animationController.forward();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.value);
    // print(_animation.value);

    if (widget.isBuy) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      text: StockUtil.formatVol(widget.value),
                      style:
                          AppTextStyle.caption2.copyWith(color: Colors.black),
                    ),
                  ),
                )),
            Expanded(
              flex: 2,
              child: Container(
                child: CustomPaint(
                  painter: PricePercentPainter(
                    isBuy: widget.isBuy,
                    color: AppColors.green_op,
                    value: _animation.value,
                    sum: widget.sum,
                  ),
                  child: Container(
                    padding: EdgeInsets.only(right: widget.padding),
                    alignment: Alignment.centerRight,
                    child: Text(
                      widget.price.toString(),
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(color: AppColors.increase),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: CustomPaint(
                  painter: PricePercentPainter(
                    isBuy: widget.isBuy,
                    color: AppColors.red_op,
                    value: _animation.value,
                    sum: widget.sum,
                  ),
                  child: Container(
                    padding: EdgeInsets.only(left: widget.padding),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.price.toString(),
                      textDirection: TextDirection.ltr,
                      style: const TextStyle(color: AppColors.decrease),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                child: RichText(
                  text: TextSpan(
                    text: StockUtil.formatVol(widget.value),
                    style: AppTextStyle.caption2.copyWith(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
