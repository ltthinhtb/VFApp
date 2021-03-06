import 'dart:io';
import 'dart:typed_data';
import 'package:vf_app/model/entities/index.dart';
import 'package:vf_app/model/params/check_account_request.dart';
import 'package:vf_app/model/order_data/inday_order.dart';
import 'package:vf_app/model/params/index.dart';
import 'package:vf_app/model/params/open_account_param.dart';
import 'package:vf_app/model/response/Image_orc_check.dart';
import 'package:vf_app/model/response/account_info.dart';
import 'package:vf_app/model/response/account_status.dart';
import 'package:vf_app/model/response/check_account_response.dart';
import 'package:vf_app/model/response/face_check_response.dart';
import 'package:vf_app/model/response/index_detail.dart';
import 'package:vf_app/model/response/list_account_response.dart';
import 'package:vf_app/model/response/open_account_response.dart';
import 'package:vf_app/model/response/portfolio.dart';
import 'package:vf_app/model/response/portfolio_account_status.dart';
import 'package:vf_app/model/stock_company_data/stock_company_data.dart';
import 'package:vf_app/model/stock_data/cash_balance.dart';
import 'package:vf_app/model/stock_data/share_balance.dart';
import 'package:vf_app/model/stock_data/stock_data.dart';
import 'package:vf_app/model/stock_data/stock_info.dart';
import 'package:vf_app/networks/api_client.dart';
import 'package:vf_app/networks/api_util.dart';
import 'package:get/get.dart';

part 'auth_api.dart';

part 'wallet_api.dart';

part 'user_api.dart';

part 'stock_order_api.dart';

part 'index_api.dart';

class ApiService extends GetxService {
  late ApiClient _apiClient;

  Future<ApiService> init() async {
    _apiClient = ApiUtil.getApiClient();
    return this;
  }
}
