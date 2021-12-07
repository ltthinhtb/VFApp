class ParamsObject {
  String? type;
  String? cmd;
  String? p1;
  String? p2;
  String? p3;
  String? p4;

  ParamsObject({this.type, this.cmd, this.p1, this.p2, this.p3, this.p4});

  ParamsObject.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    cmd = json['cmd'];
    p1 = json['p1'];
    p2 = json['p2'];
    p3 = json['p3'];
    p4 = json['p4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['cmd'] = cmd;
    if (p1 != null) {
      data['p1'] = p1;
    }
    if (p2 != null) {
      data['p2'] = p2;
    }

    if (p3 != null) {
      data['p3'] = p3;
    }
    if (p4 != null) {
      data['p4'] = p4;
    }
    return data;
  }
}
