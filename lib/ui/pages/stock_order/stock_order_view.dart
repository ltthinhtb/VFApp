import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vf_app/common/app_images.dart';
import 'package:vf_app/model/stock_company_data/stock_company_data.dart';
import 'package:vf_app/services/setting_service.dart';
import 'package:vf_app/ui/pages/stock_order/stock_order_logic.dart';
import 'package:vf_app/ui/pages/stock_order/widget/stock_order_appbar.dart';

class StockOrderPage extends StatefulWidget {
  StockOrderPage({Key? key, this.selectedStock}) : super(key: key);

  final StockCompanyData? selectedStock;

  @override
  _StockOrderPageState createState() => _StockOrderPageState();
}

class _StockOrderPageState extends State<StockOrderPage> {
  final logic = Get.put(StockOrderLogic());
  final state = Get.find<StockOrderLogic>().state;

  //Bỏ settingService đi
  final settingService = Get.find<SettingService>();

  void changeStock(StockCompanyData? data) {
    // print(data?.stockCode);
    if (data != null) {
      logic.getStockData(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StockOrderAppbar(
        onLeadingPress: () {},
        onSelectStockCode: (data) => changeStock(data),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          children: [buildTopItem(), buildHeader()],
        ),
      ),
    );
  }

  Widget buildTopItem() {
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        constraints: BoxConstraints(
            minHeight: 50,
            maxHeight: 90,
            minWidth: width - 30,
            maxWidth: width - 30),
        child: Obx(
          () => state.selectedStock.value.stockCode != null
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: state.selectedStock.value.stockCode! + "  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            TextSpan(
                              text: state.selectedStock.value.postTo!,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ]),
                        ),
                        MaterialButton(
                          onPressed: () {},
                          shape: const CircleBorder(),
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .primaryVariant,
                          child: SvgPicture.asset(AppImages.switch_diagram),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: settingService.currentLocate.value ==
                                        const Locale.fromSubtags(
                                            languageCode: 'vi')
                                    ? state.selectedStock.value.nameVn
                                    : state.selectedStock.value.nameEn ??
                                        state.selectedStock.value.nameVn,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w200,
                                    ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              : Column(
                  children: [
                    const Text('Chưa có cổ phiếu nào được chọn'),
                    const Text('Vui lòng chọn cổ phiếu muốn đặt lệnh')
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    /// bỏ Obx đi khi nào dùng đến biến obx mới để trong thẻ này
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.6)),
          child: Row(
              // children: [Expanded(child: Text(state.selectedStockData.value.))],
              ),
        ),
      ),
    );
  }
}
