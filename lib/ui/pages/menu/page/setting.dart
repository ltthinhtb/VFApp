import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/common/app_text_styles.dart';
import 'package:vf_app/ui/pages/menu/page/setting_page.dart';

class Setting extends StatefulWidget {
  Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Container(
          child: Text(
            "Cài đặt",
            style: AppTextStyle.H3,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [buildListButton()],
          ),
        ),
      ),
    );
  }

  Widget buildListButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          buildButton(
            "Ngôn ngữ",
            onPush: () => Get.to(const SettingPage()),
          ),
          buildButton("Đổi mật khẩu"),
        ],
      ),
    );
  }

  Widget buildButton(String label, {Function()? onPush}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: MaterialButton(
        onPressed: onPush ?? () {},
        color: AppColors.grayF2,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                label,
                style: AppTextStyle.H5Bold,
              ),
            ),
            const Icon(
              Icons.east_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
