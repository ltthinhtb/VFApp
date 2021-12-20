import 'package:flutter/material.dart';
import 'package:vf_app/common/app_colors.dart';

class EkycStepper extends StatelessWidget {
  final ValueNotifier<int> stepperValue;
  final bool isPreview;

  const EkycStepper(
      {Key? key, required this.stepperValue, required this.isPreview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  const Spacer(),
                  const Expanded(
                    flex: 6,
                    child: Divider(
                      height: 0,
                      thickness: 1,
                      color: AppColors.grayD7,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            )),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: stepper(1, 'Chụp ảnh và xác thực')),
            const Spacer(),
            Expanded(flex: 2, child: stepper(2, 'Bổ sung thông tin')),
            const Spacer(),
            Expanded(flex: 2, child: stepper(3, 'Ký hợp đồng')),
          ],
        ),
      ],
    );
  }

  Widget stepper(int step, String title) {
    return ValueListenableBuilder<int>(
        valueListenable: stepperValue,
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: value == step
                            ? AppColors.yellow
                            : AppColors.grayC4),
                    color: value == step ? AppColors.yellow : AppColors.gray88,
                    shape: BoxShape.circle),
                child: Text(
                  '$step',
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: AppColors.white),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: value == step
                        ? AppColors.yellow
                        : (isPreview ? AppColors.grayD7 : AppColors.white)),
              )
            ],
          );
        });
  }
}
