import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:vf_app/common/app_colors.dart';

class StockOrderAppbar extends StatefulWidget implements PreferredSizeWidget {
  StockOrderAppbar({Key? key, required this.onLeadingPress}) : super(key: key);
  final Function() onLeadingPress;

  @override
  _StockOrderAppbarState createState() => _StockOrderAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

class _StockOrderAppbarState extends State<StockOrderAppbar> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.white,
      elevation: 0,
      leadingWidth: width * 0.18,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: MaterialButton(
          onPressed: widget.onLeadingPress,
          color: AppColors.grayF2,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
            side: BorderSide.none,
          ),
          height: width * 0.18 - 15,
          child: Icon(
            Icons.arrow_back_ios_new,
            size: (width * 0.05),
          ),
        ),
      ),
      // title: TypeAheadField(
      //   textFieldConfiguration: TextFieldConfiguration(decoration: InputDecoration(prefixIcon: )),
      //   suggestionsCallback: (string) => ,
      //   itemBuilder: itemBuilder,
      //   onSuggestionSelected: onSuggestionSelected,
      // ),
    );
  }
}
