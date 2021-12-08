import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/model/stock_company_data/stock_company_data.dart';
import 'package:vf_app/ui/pages/stock_order/stock_order_logic.dart';

class StockOrderAppbar extends StatefulWidget implements PreferredSizeWidget {
  StockOrderAppbar({Key? key, required this.onLeadingPress}) : super(key: key);
  final Function() onLeadingPress;

  @override
  _StockOrderAppbarState createState() => _StockOrderAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _StockOrderAppbarState extends State<StockOrderAppbar> {
  final logic = Get.find<StockOrderLogic>();
  final state = Get.find<StockOrderLogic>().state;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AppBar(
      // backgroundColor: Colors.white,
      // foregroundColor: Colors.white,
      elevation: 0,
      leading: Material(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          side: BorderSide.none,
        ),
        color: Theme.of(context).buttonTheme.colorScheme!.primary,
        child: RawMaterialButton(
          onPressed: widget.onLeadingPress,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
            side: BorderSide.none,
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 25,
          ),
        ),
      ),

      title: TypeAheadField<StockCompanyData>(
        textFieldConfiguration: TextFieldConfiguration(
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.search_outlined,
            ),
            filled: true,
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(3),
          ],
        ),
        suggestionsCallback: (string) {
          return logic.searchStock(string);
        },
        itemBuilder: (BuildContext context, itemData) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  '${itemData.stockCode}',
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    '${itemData.nameVn}',
                  ),
                ),
              ],
            ),
          );
        },
        onSuggestionSelected: (data) {},
      ),
    );
  }
}
