import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/common/app_text_styles.dart';
import 'package:vf_app/utils/stock_utils.dart';

class BackGroundPainter extends CustomPainter {
  BackGroundPainter({
    this.color = AppColors.primary,
  });
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint _paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    Paint _linePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    Rect _rect = Rect.fromLTWH(0, 0, size.height, size.height);
    RRect _rRect = RRect.fromRectAndRadius(_rect, const Radius.circular(14));

    canvas.drawRRect(_rRect, _paint);
    canvas.translate(size.width * 0.3, size.height / 2);
    canvas.save();
    canvas.drawLine(
        const Offset(0, 0), Offset(size.width * 0.4, 0), _linePaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate != this;
  }
}

class BackGroundPainter2 extends CustomPainter {
  BackGroundPainter2({
    this.color = AppColors.primary,
  });
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint _paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    Paint _linePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    canvas.translate(size.width, size.height);
    canvas.rotate(pi);
    canvas.save();

    Rect _rect = Rect.fromLTWH(0, 0, size.height, size.height);
    RRect _rRect = RRect.fromRectAndRadius(_rect, const Radius.circular(14));

    canvas.drawRRect(_rRect, _paint);
    canvas.restore();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.save();
    for (var i = 0; i < 4; i++) {
      canvas.drawLine(
          const Offset(0, 0), Offset(size.width * 0.2, 0), _linePaint);
      canvas.rotate(pi / 2);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate != this;
  }
}

class NumberInputField extends StatefulWidget {
  NumberInputField({
    Key? key,
    required this.label,
    this.backgroundColor = Colors.transparent,
    this.buttonColor = AppColors.primary,
    required this.dist,
    required this.editingController,
    this.focusNode,
    this.enabled = true,
    this.onChange,
    this.maxLength = 20,
  }) : super(key: key);
  final Color backgroundColor;
  final Color buttonColor;
  final String label;
  final double dist;
  final TextEditingController editingController;
  final FocusNode? focusNode;
  final bool enabled;
  final ValueChanged<double>? onChange;
  final int? maxLength;

  @override
  _NumberInputFieldState createState() => _NumberInputFieldState();
}

class _NumberInputFieldState extends State<NumberInputField> {
  late Color _color;
  FocusNode? _focusNode;
  String _hintText = "";
  bool enabled = true;
  late double currentValue;
  @override
  void initState() {
    super.initState();
    if (widget.focusNode == null) {
      _focusNode = FocusNode();
    } else {
      _focusNode = widget.focusNode;
    }

    setState(() {
      _hintText = widget.label;
      _color = widget.buttonColor;
      enabled = widget.enabled;
      currentValue = double.parse(widget.editingController.text);
      widget.editingController.text = currentValue.roundNumber();
    });
    _focusNode?.addListener(() {
      // print("Has focus: ${_focusNode?.hasFocus}");
      if (_focusNode!.hasFocus) {
        _hintText = "";
      } else {
        _hintText = widget.label;
        setState(() {
          currentValue = double.parse(widget.editingController.text);
          widget.editingController.text = currentValue.roundNumber();
        });
      }
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.enabled != widget.enabled) {
      // animationController.forward();
      setState(() {
        enabled = widget.enabled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        // color: Colors.green,
        borderRadius: const BorderRadius.all(
          Radius.circular(14),
        ),
        border: Border.all(
          color: widget.buttonColor,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.center,
            child: AspectRatio(
              aspectRatio: 1,
              child: CustomPaint(
                painter: BackGroundPainter(color: _color),
                child: MaterialButton(
                  onPressed: () {
                    _focusNode?.unfocus();
                    if (enabled) {
                      if (widget.editingController.text.isANumber()) {
                        if (double.parse(widget.editingController.text) -
                                widget.dist >=
                            0) {
                          if (widget.editingController.text.isANumber()) {
                            setState(() {
                              setState(() {
                                currentValue =
                                    double.parse(widget.editingController.text);
                              });
                              widget.editingController.text =
                                  currentValue.roundNumber();
                            });
                          }
                        }
                      }
                    }
                  },
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(14),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: TextField(
                controller: widget.editingController,
                focusNode: _focusNode,
                enableSuggestions: false,
                enabled: enabled,
                autocorrect: false,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(widget.maxLength)
                ],
                onEditingComplete: () {
                  if (enabled) {
                    if (widget.editingController.text.isANumber()) {
                      setState(() {
                        setState(() {
                          currentValue =
                              double.parse(widget.editingController.text);
                        });
                        widget.editingController.text =
                            currentValue.roundNumber();
                      });
                    }
                  }
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  hintText: _hintText,
                  hintStyle: AppTextStyle.H4Regular,
                  filled: true,
                  fillColor: Colors.transparent,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            child: AspectRatio(
              aspectRatio: 1,
              child: CustomPaint(
                painter: BackGroundPainter2(color: _color),
                child: MaterialButton(
                  onPressed: () {
                    _focusNode?.unfocus();
                    if (enabled) {
                      if (widget.editingController.text.isANumber()) {
                        setState(() {
                          setState(() {
                            currentValue =
                                double.parse(widget.editingController.text) +
                                    widget.dist;
                          });
                          widget.editingController.text =
                              currentValue.roundNumber();
                        });
                      }
                    }
                  },
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(14),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension DecimalNumber on String {
  bool isANumber() {
    return RegExp(r'^[+-]?([0-9]+\.?[0-9]*|\.[0-9]+)$').hasMatch(this);
  }

  String roundDouble() {
    if (endsWith("00")) {
      return substring(0, length - 3);
    } else if (endsWith("0")) {
      return substring(0, length - 1);
    } else {
      return this;
    }
  }
}

extension Number on double {
  String roundNumber() {
    var _fomated = StockUtil.formatPrice(this).toString();
    return _fomated;
  }
}
