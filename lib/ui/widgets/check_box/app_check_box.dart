import 'package:flutter/material.dart';

class AppCheckBox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const AppCheckBox({Key? key, required this.value, required this.onChanged})
      : super(key: key);

  @override
  State<AppCheckBox> createState() => _AppCheckBoxState();
}

class _AppCheckBoxState extends State<AppCheckBox> {
  late bool _value;

  @override
  void initState() {
    _value = widget.value;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: _value,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        activeColor: Theme.of(context).primaryColor,
        tristate: false,
        onChanged: (value) {
          setState(() {
            _value = !_value;
            widget.onChanged.call(value);
          });
        });
  }
}
