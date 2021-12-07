import 'package:vf_app/model/entities/index.dart';
import 'package:vf_app/model/params/index.dart';
import 'package:vf_app/model/response/account_status.dart';
import 'package:vf_app/networks/api_client.dart';
import 'package:vf_app/networks/api_util.dart';
import 'package:get/get.dart';

part 'auth_api.dart';
part 'wallet_api.dart';

class ApiService extends GetxService {
  late ApiClient _apiClient;

  Future<ApiService> init() async {
    _apiClient = ApiUtil.getApiClient();
    return this;
  }
}
