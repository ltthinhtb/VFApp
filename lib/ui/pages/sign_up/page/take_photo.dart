import 'package:flutter/material.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/generated/l10n.dart';

class TakePhotoPage extends StatefulWidget {
  const TakePhotoPage({Key? key}) : super(key: key);

  @override
  _TakePhotoPageState createState() => _TakePhotoPageState();
}

class _TakePhotoPageState extends State<TakePhotoPage> {
  @override
  Widget build(BuildContext context) {
    final headline4 = Theme.of(context).textTheme.headline4;
    final headline6 = Theme.of(context).textTheme.headline6;
    return Scaffold(
      backgroundColor: const Color(0xff3B3B3B).withOpacity(0.6),
      appBar: AppBar(
        title: Text(S.of(context).take_photo_confirm),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Stack(
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
          ),
          const SizedBox(height: 18),
          Text(
            'Mặt trước CMND/CCCD',
            style: headline4,
          ),
        ],
      ),
    );
  }

  Widget stepper(int step, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          height: 20,
          width: 20,
          decoration: const BoxDecoration(
              color: AppColors.yellow, shape: BoxShape.circle),
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
          style: Theme.of(context).textTheme.headline6,
        )
      ],
    );
  }
}
