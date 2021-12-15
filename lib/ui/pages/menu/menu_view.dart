import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/common/app_text_styles.dart';
import 'package:vf_app/ui/pages/menu/menu_logic.dart';
import 'package:vf_app/ui/pages/menu/page/setting.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final logic = Get.put(MenuLogic());
  final state = Get.find<MenuLogic>().state;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Container(
          child: Text(
            "Menu",
            style: AppTextStyle.H3,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [buildInfoRow(), buildListButton()],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: const BoxDecoration(
          color: AppColors.grayF2,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              maxRadius: 27,
              backgroundColor: AppColors.primary,
            ),
            Container(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.name.value,
                  style: AppTextStyle.H5Bold.copyWith(color: AppColors.primary),
                ),
                Text(
                  state.acc.value,
                  style: AppTextStyle.H5Bold.copyWith(color: AppColors.primary),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildListButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          buildButton("Smart OTP"),
          buildButton("Thị trường"),
          buildButton("Giao dịch tiền"),
          buildButton("Cảnh báo"),
          buildButton("Sản phẩm Margin/Hợp tác"),
          buildButton("Xác Nhận Lệnh"),
          buildButton("Hướng dẫn sử dụng"),
          buildButton("Sao kê"),
          buildButton(
            "Cài đặt",
            onPush: () => Get.to(Setting()),
          ),
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
