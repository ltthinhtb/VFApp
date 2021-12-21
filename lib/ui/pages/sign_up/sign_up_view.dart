import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'page/check_account.dart';
import 'page/signature.dart';
import 'sign_up_logic.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final logic = Get.put(SignUpLogic());
  final state = Get.find<SignUpLogic>().state;


  @override
  Widget build(BuildContext context) {
    return const CheckAccountPage();
  }
}
