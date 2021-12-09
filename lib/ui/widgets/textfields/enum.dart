import 'package:flutter/material.dart';

enum TextFieldType {
  normal,
  search,
}

extension TextFieldExt on TextFieldType {
  OutlineInputBorder? get border {
    switch (this) {
      case TextFieldType.normal:
        return null;
      case TextFieldType.search:
        return _defaultBorder();
    }
  }

  String get data => "hello";
}

OutlineInputBorder _defaultBorder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(width: 0));
}
