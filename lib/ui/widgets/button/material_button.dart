import 'package:flutter/material.dart';
import 'package:vf_app/common/app_colors.dart';

class CustomMaterialButton extends StatefulWidget {
  CustomMaterialButton(
      {Key? key, required this.onPressed, required this.child, this.color})
      : super(key: key);
  final Function() onPressed;
  final Widget child;
  final Color? color;

  @override
  _CustomMaterialButtonState createState() => _CustomMaterialButtonState();
}

class _CustomMaterialButtonState extends State<CustomMaterialButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.color ?? AppColors.primary2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: MaterialButton(
        padding: const EdgeInsets.all(0),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: widget.onPressed,
        child: widget.child,
      ),
    );
  }
}
