import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/model/enums/gender_type.dart';
import 'package:vf_app/ui/widgets/button/button_filled.dart';
import 'package:vf_app/ui/widgets/textfields/app_text_field.dart';

import '../sign_up_logic.dart';

class OrcInfo extends StatefulWidget {
  final ValueNotifier<int> stepperValue;

  const OrcInfo({Key? key, required this.stepperValue}) : super(key: key);

  @override
  State<OrcInfo> createState() => _OrcInfoState();
}

class _OrcInfoState extends State<OrcInfo> {
  final logic = Get.find<SignUpLogic>();
  final state = Get.find<SignUpLogic>().state;

  GenderType _genderType = GenderType.male;

  @override
  Widget build(BuildContext context) {
    final headline5 = Theme.of(context).textTheme.headline5;
    final headline6 = Theme.of(context).textTheme.headline5;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(S.of(context).profile_info, style: headline5),
          const SizedBox(height: 20),
          rowData('${S.of(context).phone}:', state.phoneNameController.text),
          const SizedBox(height: 20),
          rowData('${S.of(context).email}:', state.emailNameController.text),
          const SizedBox(height: 20),
          AppTextFieldWidget(
            inputController: state.fullNameController,
            label: S.of(context).full_name,
            readOnly: true,
          ),
          const SizedBox(height: 20),
          Text(
            S.of(context).gender,
            style: headline6!.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              radioGender(GenderType.male),
              radioGender(GenderType.female)
            ],
          ),
          const SizedBox(height: 20),
          AppTextFieldWidget(
            readOnly: true,
            label: S.of(context).birthday,
            inputController:
                TextEditingController(text: state.identityCard.dob),
          ),
          const SizedBox(height: 20),
          AppTextFieldWidget(
            readOnly: true,
            label: S.of(context).identity_card,
            inputController: TextEditingController(text: state.identityCard.id),
          ),
          const SizedBox(height: 20),
          AppTextFieldWidget(
            readOnly: true,
            label: S.of(context).issue_date_cmt,
            inputController:
                TextEditingController(text: state.identityCardBack.issueDate),
          ),
          const SizedBox(height: 20),
          AppTextFieldWidget(
            readOnly: true,
            label: S.of(context).issue_loc,
            inputController:
                TextEditingController(text: state.identityCardBack.issueLoc),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: ButtonFill(
                  voidCallback: () {},
                  title: S.of(context).redo,
                  type: ButtonEnums.cancel,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ButtonFill(
                  voidCallback: () {
                    widget.stepperValue.value = 3;
                  },
                  title: S.of(context).continue_step,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget radioGender(GenderType gender) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _genderType = gender;
            state.sex = _genderType.value;
          });
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: _genderType == gender
                          ? Theme.of(context).primaryColor
                          : AppColors.black)),
              child: Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _genderType == gender
                        ? Theme.of(context).primaryColor
                        : null),
              ),
            ),
            const SizedBox(width: 10),
            Text(gender.vnText, style: Theme.of(context).textTheme.headline6)
          ],
        ),
      ),
    );
  }

  Widget rowData(String title, String value) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              title,
              style: headline6,
            )),
        Expanded(
            flex: 2,
            child: Text(
              value,
              style: headline6!.copyWith(fontWeight: FontWeight.w700),
            ))
      ],
    );
  }
}
