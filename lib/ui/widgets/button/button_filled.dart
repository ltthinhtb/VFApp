import 'package:flutter/material.dart';
import 'package:vf_app/common/app_colors.dart';

class ButtonFill extends StatelessWidget {
  final VoidCallback? voidCallback;
  final String title;
  final ButtonEnums type;
  final ButtonStyle? style;

  const ButtonFill(
      {Key? key,
      required this.voidCallback,
      required this.title,
      this.type = ButtonEnums.fill,
      this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: style ?? type.type,
      onPressed: voidCallback,
      child: Text(title),
    );
  }
}

enum ButtonEnums { fill, cancel }

extension ButtonTypeExt on ButtonEnums {
  ButtonStyle? get type {
    switch (this) {
      case ButtonEnums.fill:
        return null;
      case ButtonEnums.cancel:
        return ElevatedButton.styleFrom(
            primary: AppColors.mainMenu2,
            onPrimary: AppColors.primary,
            elevation: 0);
    }
  }
}
