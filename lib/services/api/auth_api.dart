part of 'api_service.dart';

extension AuthApiService on ApiService {
  Future<TokenEntity?> signIn(String username, String password) async {
    return await _apiClient.authLogin(username, password);
  }
}
