import 'package:vf_app/generated/l10n.dart';

class Validator {

  String? checkUser(String value) {
    if (value.isEmpty) {
      return S.current.please_input_user;
    } else {
      return null;
    }
  }

  String? checkPass(String value) {
    if (value.isEmpty) {
      return S.current.please_input_password;
    } else {
      return null;
    }
  }

}
