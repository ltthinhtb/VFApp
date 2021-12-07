part of 'api_service.dart';

extension WaletService on ApiService {
  Future<AccountStatus?> getAccountStatus(RequestParams requestParams) async {
    return await _apiClient.getAccountStatus(requestParams);
  }
}
