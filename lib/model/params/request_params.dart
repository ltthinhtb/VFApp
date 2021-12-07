import 'data_params.dart';

class RequestParams {
  String? group;
  String? user;
  String? session;
  String? channel;
  ParamsObject? data;

  RequestParams({this.group, this.user, this.session, this.channel, this.data});

  RequestParams.fromJson(Map<String, dynamic> json) {
    group = json['group'];
    user = json['user'];
    session = json['session'];
    channel = json['channel'];
    data = json['data'] != null ? ParamsObject.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['group'] = group;
    data['user'] = user;
    data['session'] = session;
    data['channel'] = channel;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
