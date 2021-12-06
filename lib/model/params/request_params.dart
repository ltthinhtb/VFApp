import 'package:uuid/uuid.dart';

import 'data_params.dart';

class RequestParams {
  String? user;
  String? cardId;
  String? group;
  String? otp;
  String? chanel;
  String? session;
  String? _refId = const Uuid().v4();
  ParamsObject? data;

  RequestParams(
      {this.user,
        this.cardId,
        this.group,
        this.otp,
        this.chanel,
        this.session,
        this.data});

  RequestParams.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    cardId = json['card_id'];
    group = json['group'];
    otp = json['otp'];
    chanel = json['chanel'];
    session = json['session'];
    _refId = json['refId'];
    if (json['data'] != null) {
      data = ParamsObject.fromJson(json['data']);
    } else {
      data = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['card_id'] = cardId;
    data['group'] = group;
    data['otp'] = otp;
    data['chanel'] = chanel;
    data['session'] = session;
    data['refId'] = _refId;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}


