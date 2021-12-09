import 'package:flutter/material.dart';
import 'package:vf_app/common/app_colors.dart';

class AnimatedSwitch extends StatefulWidget {
  AnimatedSwitch({
    Key? key,
    required this.trueLabel,
    required this.falseLabel,
    required this.value,
    required this.trueColor,
    required this.falseColor,
    this.backgroundColor = AppColors.grayF2,
    this.padding = 0,
    required this.onChange,
  }) : super(key: key);
  final String trueLabel;
  final String falseLabel;
  final bool value;
  final Color backgroundColor;
  final Color trueColor;
  final Color falseColor;
  final double padding;
  final ValueChanged<bool> onChange;

  @override
  _AnimatedSwitchState createState() => _AnimatedSwitchState();
}

class _AnimatedSwitchState extends State<AnimatedSwitch>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
  late Color _color;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    var curvedAnimation =
        CurvedAnimation(parent: animationController, curve: Curves.linear);
    animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation)
      ..addListener(() {
        setState(() {
          if (widget.value) {
            _color = widget.trueColor;
          } else {
            _color = widget.falseColor;
          }
        });
      });
    setState(() {
      if (widget.value) {
        _color = widget.trueColor;
      } else {
        _color = widget.falseColor;
      }
    });

    if (!widget.value) {
      animationController.forward();
    }
    return;
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (widget.value) {
        animationController.reverse();
      } else {
        animationController.forward();
      }
      // animationController.forward();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: AppColors.grayF2,
          )),
      child: Stack(
        fit: StackFit.loose,
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: _color,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              margin: EdgeInsets.only(
                left:
                    animation.value * ((width - (widget.padding * 2) - 4) / 2),
                right: (1 - animation.value) *
                    ((width - (widget.padding * 2) - 4) / 2),
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.onChange.call(true);
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      child: Text(
                        widget.trueLabel,
                        style: TextStyle(
                          color: !widget.value ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.onChange.call(false);
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      alignment: Alignment.center,
                      child: Text(
                        widget.falseLabel,
                        style: TextStyle(
                          color: widget.value ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}