import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vf_app/common/app_images.dart';

class AppTextFieldWidget extends StatefulWidget {
  final TextEditingController? inputController;
  final ValueChanged<String>? onChanged;
  final TextInputType? textInputType;
  final String? label;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final bool obscureText;
  final FocusNode? focusNode;
  final bool autoFocus;
  final SvgPicture? prefixIcon;
  final int? maxLength;

  AppTextFieldWidget({
    this.inputController,
    this.onChanged,
    this.textInputType,
    this.label,
    this.hintText,
    this.validator,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.focusNode,
    this.autoFocus = false,
    this.prefixIcon,
    this.maxLength,
  });

  @override
  State<AppTextFieldWidget> createState() => _AppTextFieldWidgetState();
}

class _AppTextFieldWidgetState extends State<AppTextFieldWidget> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.obscureText;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: widget.label != null,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                widget.label ?? "",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            )),
        TextFormField(
          autofocus: widget.autoFocus,
          focusNode: widget.focusNode ?? FocusNode(),
          controller: widget.inputController,
          obscureText: _obscureText,
          onFieldSubmitted: widget.onFieldSubmitted,
          inputFormatters: [
            LengthLimitingTextInputFormatter(widget.maxLength),
          ],
          decoration: InputDecoration(
              isDense: true,
              filled: true,
              hintText: widget.hintText,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              prefixIconConstraints: const BoxConstraints(maxHeight: 24),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: widget.prefixIcon,
              ),
              suffixIconConstraints: const BoxConstraints(maxHeight: 24),
              suffixIcon: widget.obscureText
                  ? GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SvgPicture.asset(
                            _obscureText ? AppImages.eye : AppImages.eye_lock),
                      ),
                    )
                  : null),
          keyboardType: widget.textInputType,
          onChanged: widget.onChanged,
          validator: widget.validator,
        ),
      ],
    );
  }
}
