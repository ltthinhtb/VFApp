import 'package:flutter/material.dart';
import 'package:vf_app/generated/l10n.dart';

class SignUpOTPPage extends StatefulWidget {
  const SignUpOTPPage({Key? key}) : super(key: key);

  @override
  _SignUpOTPPageState createState() => _SignUpOTPPageState();
}

class _SignUpOTPPageState extends State<SignUpOTPPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).register_form),
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
