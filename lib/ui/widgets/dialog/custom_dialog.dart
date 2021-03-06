import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:vf_app/common/app_text_styles.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/model/order_data/change_order_data.dart';
import 'package:vf_app/ui/widgets/textfields/app_text_field.dart';

class CustomDialog {
  static Future<bool?> showConfirmDialog(
      GlobalKey? key, String label, List<String> contents,
      {List<Color>? buttonColors, List<Color>? textButtonColors}) async {
    return await showDialog<bool>(
      context: key!.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: Text(
                      label,
                      style: AppTextStyle.H3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: contents.length,
                        itemBuilder: (context, i) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            child: Text(
                              contents[i],
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Material(
                              color: buttonColors != null
                                  ? buttonColors[0]
                                  : Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: MaterialButton(
                                padding: const EdgeInsets.all(0),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text(
                                  S.of(context).cancel,
                                  style: TextStyle(
                                      color: textButtonColors != null
                                          ? textButtonColors[0]
                                          : null),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Material(
                              color: buttonColors != null
                                  ? buttonColors[1]
                                  : Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                // side: BorderSide(width: 0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: MaterialButton(
                                padding: const EdgeInsets.all(0),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: Text(
                                  S.of(context).confirm,
                                  style: TextStyle(
                                      color: textButtonColors != null
                                          ? textButtonColors[1]
                                          : null),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                      // children: buttonlabels.map((e) {
                      //   int i = buttonlabels.indexOf(e);
                      //   return Expanded(
                      //     flex: 1,
                      //     child: Padding(
                      //       padding: const EdgeInsets.symmetric(horizontal: 5),
                      //       child: Material(
                      //         color: buttonColors != null
                      //             ? buttonColors[i]
                      //             : Colors.transparent,
                      //         shape: const RoundedRectangleBorder(
                      //           side: BorderSide(),
                      //           borderRadius: BorderRadius.all(
                      //             Radius.circular(5),
                      //           ),
                      //         ),
                      //         child: MaterialButton(
                      //           padding: const EdgeInsets.all(0),
                      //           materialTapTargetSize:
                      //               MaterialTapTargetSize.shrinkWrap,
                      //           onPressed: () => Navigator.of(context).pop(i),
                      //           child: Text(
                      //             buttonlabels[i],
                      //             style: TextStyle(
                      //                 color: textButtonColors != null
                      //                     ? textButtonColors[i]
                      //                     : null),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   );
                      // }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<ChangeOrderData?> showChangeOrderDialog(
      GlobalKey? key, String label, List<String> contents,
      {List<Color>? buttonColors, List<Color>? textButtonColors}) async {
    final TextEditingController price_controller = TextEditingController();
    final TextEditingController vol_controller = TextEditingController();
    return await showDialog<ChangeOrderData?>(
      context: key!.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: Text(
                      label,
                      style: AppTextStyle.H3,
                    ),
                  ),
                  AppTextFieldWidget(
                    inputController: price_controller,
                    label: S.of(context).price,
                    hintText: S.of(context).price,
                  ),
                  AppTextFieldWidget(
                    inputController: vol_controller,
                    label: S.of(context).volume_short,
                    hintText: S.of(context).volumn,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 20, vertical: 10),
                  //   child: ListView.builder(
                  //       shrinkWrap: true,
                  //       itemCount: contents.length,
                  //       itemBuilder: (context, i) {
                  //         return Container(
                  //           margin: const EdgeInsets.symmetric(vertical: 10),
                  //           alignment: Alignment.center,
                  //           child: Text(
                  //             contents[i],
                  //             style: const TextStyle(color: Colors.black),
                  //           ),
                  //         );
                  //       }),
                  // ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Material(
                              color: buttonColors != null
                                  ? buttonColors[0]
                                  : Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: MaterialButton(
                                padding: const EdgeInsets.all(0),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onPressed: () =>
                                    Navigator.of(context).pop(null),
                                child: Text(
                                  S.of(context).cancel,
                                  style: TextStyle(
                                      color: textButtonColors != null
                                          ? textButtonColors[0]
                                          : null),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Material(
                              color: buttonColors != null
                                  ? buttonColors[1]
                                  : Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                // side: BorderSide(width: 0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: MaterialButton(
                                padding: const EdgeInsets.all(0),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onPressed: () => Navigator.of(context).pop(
                                  ChangeOrderData(
                                    price: price_controller.text,
                                    vol: vol_controller.text,
                                  ),
                                ),
                                child: Text(
                                  S.of(context).confirm,
                                  style: TextStyle(
                                      color: textButtonColors != null
                                          ? textButtonColors[1]
                                          : null),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
