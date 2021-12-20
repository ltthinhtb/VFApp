part of 'api_service.dart';

extension AuthApiService on ApiService {
  Future<TokenEntity?> signIn(RequestParams requestParams) async {
    return await _apiClient.authLogin(requestParams);
  }

  Future<CheckAccountResponse> checkAccountStatus(
      CheckAccountRequest request) async {
    return await _apiClient.checkAccountStatus(request);
  }

  Future<String> uploadFile(File file, String key) async {
    return await _apiClient.uploadFile(file, key);
  }

  Future<ImageOrcCheck> checkOcr(String url) async {
    return await _apiClient.checkOcr(url);
  }
}
