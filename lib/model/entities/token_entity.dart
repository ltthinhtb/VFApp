class TokenEntity {
  int? rc;
  String? rs;
  String? cmd;
  Data? data;

  TokenEntity({this.rc, this.rs, this.cmd, this.data});

  TokenEntity.fromJson(Map<String, dynamic> json) {
    rc = json['rc'];
    rs = json['rs'];
    cmd = json['cmd'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rc'] = rc;
    data['rs'] = rs;
    data['cmd'] = cmd;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? active;
  late String user;
  late String name;
  late String cardId;
  late String custCode;
  late String session;
  String? type;

  Data(
      {this.active,
      required this.user,
      required this.name,
      required this.cardId,
      required this.custCode,
      required this.session,
      this.type});

  Data.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    user = json['user'];
    name = json['name'];
    cardId = json['card_id'];
    custCode = json['cust_code'];
    session = json['session'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['active'] = active;
    data['user'] = user;
    data['name'] = name;
    data['card_id'] = cardId;
    data['cust_code'] = custCode;
    data['session'] = session;
    data['type'] = type;
    return data;
  }
}
