part of 'api_service.dart';

extension UserApiService on ApiService {
  Future<List<Account>?> getListAccount(RequestParams requestParams) async {
    return await _apiClient.getListAccount(requestParams);
  }

  Future<void> changePassword(RequestParams requestParams) async {
    return await _apiClient.changePassword(requestParams);
  }
}
