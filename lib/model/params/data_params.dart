class ParamsObject {
  String? cmd;
  Map? param;

  ParamsObject({this.cmd, this.param});

  ParamsObject.fromJson(Map<String, dynamic> json) {
    cmd = json['cmd'];
    param = json['param'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cmd'] = cmd;
    if (param != null) {
      data['param'] = param;
    }
    return data;
  }
}
