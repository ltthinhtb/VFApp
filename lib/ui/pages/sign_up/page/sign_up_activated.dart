import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/common/app_images.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/ui/commons/app_dialog.dart';
import 'package:vf_app/ui/commons/appbar.dart';
import 'package:vf_app/ui/commons/timmer_coutdown.dart';
import 'package:vf_app/ui/pages/sign_up/widget/alert_dialog.dart';
import 'package:vf_app/ui/widgets/button/button_filled.dart';

import '../sign_up_logic.dart';

class ActivatedPage extends StatefulWidget {
  const ActivatedPage({Key? key}) : super(key: key);

  @override
  _ActivatedPageState createState() => _ActivatedPageState();
}

class _ActivatedPageState extends State<ActivatedPage> {
  final logic = Get.find<SignUpLogic>();
  final state = Get.find<SignUpLogic>().state;

  @override
  Widget build(BuildContext context) {
    final headline2 = Theme.of(context).textTheme.headline2;
    final headline6 = Theme.of(context).textTheme.headline6;
    final headline3 = Theme.of(context).textTheme.headline6;
    return Scaffold(
      appBar: AppBarCustom(title: S.of(context).activated_account,),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Center(
            child: Text(
              '064c478832',
              style: headline2!.copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Center(
              child: Text(
                'Kích hoạt tài khoản trước 15:50 22/10/2021 để giữ số tài khoản',
                textAlign: TextAlign.center,
                style: headline6,
              ),
            ),
          ),
          const SizedBox(height: 10),
          TimeCountDown(
            duration: const Duration(minutes: 50),
            textStyle: headline3!.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: DottedBorder(
              borderType: BorderType.RRect,
              color: AppColors.grayD7,
              radius: const Radius.circular(15),
              padding: const EdgeInsets.symmetric(horizontal: 51, vertical: 30),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Chỉ cần 1 phút để thực hiện',
                      style: headline6!.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 25),
                  rowStep(1, AppImages.sign_up_card_id_1,
                      'Chụp ảnh giấy tờ tùy thân Xác nhận gương mặt'),
                  dividerCustom(),
                  rowStep(2, AppImages.sign_up_card_id_2, 'Bổ sung thông tin'),
                  dividerCustom(),
                  rowStep(3, AppImages.sign_up_card_id_3, 'Ký hợp đồng'),
                ],
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: ButtonFill(
                      type: ButtonEnums.cancel,
                      voidCallback: () {},
                      title: S.of(context).later),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ButtonFill(
                      voidCallback: () {
                        AppDialog.showDialog(
                            title: S.of(context).choose_identity,
                            content: AlertDialogCustom(
                              radio: state.enumRadio,
                            ));
                      },
                      title: S.of(context).activated_now),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30)
        ],
      ),
    );
  }

  Widget dividerCustom() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          height: 61,
          child: VerticalDivider(
            width: 1,
            color: AppColors.gray88,
          ),
        ),
      ),
    );
  }

  Widget rowStep(int step, String imageIcon, String title) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          child: Text(
            "$step",
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: AppColors.white),
          ),
        ),
        const SizedBox(width: 20),
        SvgPicture.asset(imageIcon),
        const SizedBox(width: 15),
        Flexible(
            child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ))
      ],
    );
  }
}
