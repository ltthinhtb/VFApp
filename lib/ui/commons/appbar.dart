import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vf_app/common/app_images.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool root;

  const AppBarCustom({Key? key, required this.title, this.root = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      flexibleSpace: ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
        child: Image.asset(
          AppImages.eye_lock,
          fit: BoxFit.cover,
        ),
      ),
      automaticallyImplyLeading: false,
      leadingWidth: !root ? kToolbarHeight : 0,
      leading: Visibility(
        visible: !root,
        child: GestureDetector(
            onTap: () => Get.back(),
            behavior: HitTestBehavior.opaque,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(19, 19.5, 0, 19.5),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: SvgPicture.asset(AppImages.eye_lock)))),
      ),
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
