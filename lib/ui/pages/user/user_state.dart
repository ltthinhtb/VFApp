import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:vf_app/model/response/list_account_response.dart';

class UserState {
  var listAccount = <Account>[];

  final account = Account().obs;
  UserState() {
    ///Initialize variables
  }
}
