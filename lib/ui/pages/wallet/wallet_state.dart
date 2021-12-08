import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:vf_app/model/response/account_status.dart';

class WalletState {
  final assets = AccountAssets().obs;

  WalletState() {
    ///Initialize variables
  }
}
