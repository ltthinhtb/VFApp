part of 'api_service.dart';

extension UserApiService on ApiService {
  Future<ListAccountResponse?> getListAccount(
      RequestParams requestParams) async {
    return await _apiClient.getListAccount(requestParams);
  }
}
