import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vf_app/common/app_colors.dart';
import 'package:vf_app/common/app_images.dart';
import 'package:vf_app/common/app_text_styles.dart';
import 'package:vf_app/generated/l10n.dart';
import 'package:vf_app/model/stock_company_data/stock_company_data.dart';
import 'package:vf_app/services/setting_service.dart';
import 'package:vf_app/ui/pages/stock_order/stock_order_logic.dart';
import 'package:vf_app/ui/pages/stock_order/widget/stock_order_appbar.dart';
import 'package:vf_app/ui/widgets/animation_widget/price_row.dart';
import 'package:vf_app/ui/widgets/animation_widget/switch.dart';
import 'package:vf_app/ui/widgets/animation_widget/total_volumn_row.dart';
import 'package:vf_app/utils/stock_utils.dart';

class StockOrderPage extends StatefulWidget {
  StockOrderPage({Key? key, this.selectedStock, this.isBuy = true})
      : super(key: key);
  final bool isBuy;
  final StockCompanyData? selectedStock;

  @override
  _StockOrderPageState createState() => _StockOrderPageState();
}

class _StockOrderPageState extends State<StockOrderPage> {
  final logic = Get.put(StockOrderLogic());
  final state = Get.find<StockOrderLogic>().state;
  final settingService = Get.find<SettingService>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      state.isBuy.value = widget.isBuy;
    });
  }

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
        child: RefreshIndicator(
          onRefresh: () async {},
          child: ListView(
            // primary: false,
            // physics: const NeverScrollableScrollPhysics(),
            children: [
              buildTopItem(),
              buildHeader(),
              build3Gia(),
              buildVolPercent(),
              buildBSButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTopItem() {
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
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
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: state.selectedStockData.value.lastPrice != null
              ? AppColors.primary2
              : AppColors.primaryOpacity,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Text(
                state.selectedStockData.value.lastPrice != null
                    ? state.selectedStockData.value.lastPrice.toString()
                    : "0.0",
                style: AppTextStyle.H1.copyWith(
                  color: state.selectedStockData.value.lastPrice != null
                      ? StockUtil.itemColor(state.selectedStockData.value)
                      : null,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.selectedStockData.value.ot != null
                        ? StockUtil.valueSign(state.selectedStockData.value) +
                            state.selectedStockData.value.ot!
                        : "0.0",
                    style: AppTextStyle.bodyText1.copyWith(
                      color: state.selectedStockData.value.ot != null
                          ? StockUtil.itemColor(state.selectedStockData.value)
                          : null,
                    ),
                  ),
                  Text(
                    state.selectedStockData.value.changePc != null
                        ? StockUtil.valueSign(state.selectedStockData.value) +
                            state.selectedStockData.value.changePc! +
                            "%"
                        : "0.0%",
                    style: AppTextStyle.bodyText1.copyWith(
                      color: state.selectedStockData.value.ot != null
                          ? StockUtil.itemColor(state.selectedStockData.value)
                          : null,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    S.of(context).volumn,
                    style: AppTextStyle.caption2,
                  ),
                  Text(
                    state.selectedStockData.value.lot != null
                        ? StockUtil.formatVol10(
                            state.selectedStockData.value.lot!)
                        : "0",
                    style: AppTextStyle.bodyText2,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    S.of(context).ceil,
                    style: AppTextStyle.caption2,
                  ),
                  Text(
                    state.selectedStockData.value.c != null
                        ? state.selectedStockData.value.c!.toString()
                        : "0",
                    style: AppTextStyle.bodyText2,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    S.of(context).reference_short,
                    style: AppTextStyle.caption2,
                  ),
                  Text(
                    state.selectedStockData.value.r != null
                        ? state.selectedStockData.value.r!.toString()
                        : "0",
                    style: AppTextStyle.bodyText2,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    S.of(context).floor,
                    style: AppTextStyle.caption2,
                  ),
                  Text(
                    state.selectedStockData.value.f != null
                        ? state.selectedStockData.value.f!.toString()
                        : "0",
                    style: AppTextStyle.bodyText2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget build3Gia() {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  PricePercentRow(
                    sum: state.sumBuyVol.value,
                    price: state.selectedStockData.value.g1?.price ?? "0.0",
                    value:
                        state.selectedStockData.value.g1?.volumn?.toDouble() ??
                            0,
                  ),
                  PricePercentRow(
                    sum: state.sumBuyVol.value,
                    price: state.selectedStockData.value.g2?.price ?? "0.0",
                    value:
                        state.selectedStockData.value.g2?.volumn?.toDouble() ??
                            0,
                  ),
                  PricePercentRow(
                    sum: state.sumBuyVol.value,
                    price: state.selectedStockData.value.g3?.price ?? "0.0",
                    value:
                        state.selectedStockData.value.g3?.volumn?.toDouble() ??
                            0,
                  )
                ],
              ),
            ),
            Container(
              width: 5,
            ),
            Expanded(
              child: Column(
                children: [
                  PricePercentRow(
                    isBuy: false,
                    sum: state.sumSellVol.value,
                    price: state.selectedStockData.value.g4?.price ?? "0.0",
                    value:
                        state.selectedStockData.value.g4?.volumn?.toDouble() ??
                            0,
                  ),
                  PricePercentRow(
                    isBuy: false,
                    sum: state.sumSellVol.value,
                    price: state.selectedStockData.value.g5?.price ?? "0.0",
                    value:
                        state.selectedStockData.value.g5?.volumn?.toDouble() ??
                            0,
                  ),
                  PricePercentRow(
                    isBuy: false,
                    sum: state.sumSellVol.value,
                    price: state.selectedStockData.value.g6?.price ?? "0.0",
                    value:
                        state.selectedStockData.value.g6?.volumn?.toDouble() ??
                            0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildVolPercent() {
    return Obx(
      () => Container(
        // margin: const EdgeInsets.only(bottom: 5),
        child: TotalVolumnPercentRow(
          sum: state.sumBSVol.value,
          buyValue: state.sumBuyVol.value,
          sellValue: state.sumSellVol.value,
        ),
      ),
    );
  }

  Widget buildBSButton() {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: AnimatedSwitch(
          trueLabel: S.of(context).buy,
          falseLabel: S.of(context).sell,
          value: state.isBuy.value,
          trueColor: AppColors.green,
          falseColor: AppColors.red,
          padding: 15,
          onChange: (val) => state.isBuy.value = val,
        ),
      ),
    );
  }
}
