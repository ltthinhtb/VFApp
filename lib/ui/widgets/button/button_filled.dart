import 'package:flutter/material.dart';

class ButtonFill extends StatelessWidget {
  final VoidCallback? voidCallback;
  final String title;

  const ButtonFill({Key? key, required this.voidCallback, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: voidCallback, child: Text(title));
  }
}
