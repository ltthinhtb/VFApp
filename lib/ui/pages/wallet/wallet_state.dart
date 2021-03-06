import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:vf_app/model/response/account_status.dart';
import 'package:vf_app/model/response/portfolio.dart';
import 'package:vf_app/model/response/portfolio_account_status.dart';
import 'package:vf_app/ui/commons/money_text_controller.dart';

class WalletState {
  final assets = AccountAssets().obs;
  final portfolioTotal = PortfolioStatus().obs;
  final portfolioList = <PortfolioStatus>[].obs;

  final portfolioAccount = PortfolioAccount().obs;

  final profitController = MoneyMaskedTextController(
    thousandSeparator: ',',
    initialValue: 0,
    rightSymbol: " đ",
    decimalSeparator: "",
    precision: 0,
  );

  String get money {
    try {
      return profitController.numberValue.toStringAsFixed(0);
    } catch (e) {
      return "0";
    }
  }

  WalletState() {
    ///Initialize variables
  }
}
