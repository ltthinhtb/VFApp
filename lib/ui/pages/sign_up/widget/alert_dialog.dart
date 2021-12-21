import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/router/route_config.dart';
import 'package:vf_app/ui/widgets/button/button_filled.dart';

import '../sign_up_logic.dart';

class AlertDialogCustom extends StatefulWidget {
  final EnumRadio radio;

  const AlertDialogCustom({Key? key, required this.radio}) : super(key: key);

  @override
  _AlertDialogCustomState createState() => _AlertDialogCustomState();
}

enum EnumRadio { passport, identity_card }

extension EnumRadioExt on EnumRadio {
  String title(BuildContext context) {
    switch (this) {
      case EnumRadio.passport:
        return S.of(context).passport;
      case EnumRadio.identity_card:
        return S.of(context).identity_card;
    }
  }
}

class _AlertDialogCustomState extends State<AlertDialogCustom> {
  EnumRadio _radio = EnumRadio.passport;

  final logic = Get.find<SignUpLogic>();
  final state = Get.find<SignUpLogic>().state;

  @override
  void initState() {
    _radio = widget.radio;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Text(
            'Chọn 1 trong 3 giấy tờ sau để xác thực',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 20),
          rowRadio(EnumRadio.passport),
          rowRadio(EnumRadio.identity_card),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ButtonFill(
                    voidCallback: () {
                      state.enumRadio = _radio;
                      Get.toNamed(RouteConfig.sign_up_photo);
                    },
                    title: S.of(context).choose)),
          )
        ],
      ),
    );
  }

  Widget rowRadio(EnumRadio passport) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _radio = passport;
        });
      },
      child: Row(
        children: [
          Radio<EnumRadio>(
            value: _radio,
            groupValue: passport,
            onChanged: (value) {
              print(value);
              setState(() {
                _radio = passport;
              });
            },
          ),
          const SizedBox(width: 10),
          Flexible(
              child: Text(
            passport.title(context),
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w700),
          ))
        ],
      ),
    );
  }
}
