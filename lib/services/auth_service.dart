import 'package:vf_app/database/secure_storage_helper.dart';
import 'package:vf_app/model/entities/index.dart';
import 'package:get/get.dart';
import 'package:vf_app/utils/logger.dart';

class AuthService extends GetxService {
  Rxn<TokenEntity> token = Rxn<TokenEntity>();

  Future<AuthService> init() async {
    final currentToken = await SecureStorageHelper.getInstance().getToken();
    token.value = currentToken;
    return this;
  }

  /// Handle save/remove Token
  void saveToken(TokenEntity token) {
   try{
     return SecureStorageHelper.getInstance().saveToken(token);
   }
   catch(e){
     logger.e(e.toString());
     throw Exception();
   }
  }

  Future<TokenEntity?> getToken() async {
    try{
      final currentToken = await SecureStorageHelper.getInstance().getToken();
      token.value = currentToken;
      return token.value;
    }
    catch(e){
      return null;
    }
  }

  void removeToken() {
    return SecureStorageHelper.getInstance().removeToken();
  }

  /// User

  /// SignOut
  void signOut() async {
    removeToken();
  }
}
