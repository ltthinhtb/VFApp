import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/common/app_images.dart';

class CmndCheck extends StatelessWidget {
  final ValueNotifier<int> stepperValue;
  final bool isPreview;

  const CmndCheck(
      {Key? key, required this.stepperValue, required this.isPreview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return ValueListenableBuilder<int>(
        valueListenable: stepperValue,
        builder: (context, value, child) {
          return Visibility(
            visible: value == 1,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Không được chụp',
                      style: headline6!.copyWith(
                          color: isPreview ? AppColors.black : AppColors.white,fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      cmndComponent(context, 'CMND bị mờ', AppImages.cmnd_blur),
                      cmndComponent(
                          context, "CMND quá tối", AppImages.cmnd_dark),
                      cmndComponent(context, "CMND cắt góc", AppImages.cmnd_cut)
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget cmndComponent(BuildContext context, String title, String image) {
    return Expanded(
        child: Column(
      children: [
        SvgPicture.asset(image),
        const SizedBox(height: 12),
        Text(
          title,
          style: Theme.of(context).textTheme.headline5!.copyWith(
              color: isPreview ? AppColors.black : AppColors.white,
              fontSize: 12),
        )
      ],
    ));
  }
}
