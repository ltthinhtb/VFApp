class CheckAccountRequest {
  String? user;
  String? cmd;
  Param ?param;

  CheckAccountRequest({this.user, this.cmd, this.param});

  CheckAccountRequest.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    cmd = json['cmd'];
    param = json['param'] != null ? Param.fromJson(json['param']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['cmd'] = cmd;
    if (param != null) {
      data['param'] = param!.toJson();
    }
    return data;
  }
}

class Param {
  String? cCUSTOMERCODE;

  Param({this.cCUSTOMERCODE});

  Param.fromJson(Map<String, dynamic> json) {
    cCUSTOMERCODE = json['C_CUSTOMER_CODE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['C_CUSTOMER_CODE'] = cCUSTOMERCODE;
    return data;
  }
}
