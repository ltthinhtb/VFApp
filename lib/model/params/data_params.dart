class ParamsObject {
  String? type;
  String? cmd;
  String? p1;
  String? p2;
  String? p3;
  String? p4;
  //Order
  String? pin;
  String? orderType;
  //NewOrder
  String? account;
  String? side;
  String? symbol;
  int? volume;
  String? price;
  String? advance;
  String? refId;

  //ChangeOrder
  String? orderNo;
  String? nvol;
  String? nprice;

  //CancelOrder
  String? fisID;

  ParamsObject({
    this.type,
    this.cmd,
    this.p1,
    this.p2,
    this.p3,
    this.p4,
    this.account,
    this.side,
    this.symbol,
    this.volume,
    this.price,
    this.advance,
    this.refId,
    this.pin,
    this.orderNo,
    this.orderType,
    this.nvol,
    this.nprice,
    this.fisID,
  });

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
    if (p1 != null) {
      data['account'] = account;
    }
    if (p1 != null) {
      data['side'] = side;
    }
    if (p1 != null) {
      data['symbol'] = symbol;
    }
    if (p1 != null) {
      data['volume'] = volume;
    }
    if (p1 != null) {
      data['price'] = price;
    }
    if (p1 != null) {
      data['advance'] = advance;
    }
    if (p1 != null) {
      data['refId'] = refId;
    }
    if (p1 != null) {
      data['pin'] = pin;
    }
    if (p1 != null) {
      data['orderNo'] = orderNo;
    }
    if (p1 != null) {
      data['orderType'] = orderType;
    }
    if (p1 != null) {
      data['nvol'] = nvol;
    }
    if (p1 != null) {
      data['nprice'] = nprice;
    }
    if (p1 != null) {
      data['fisID'] = fisID;
    }
    return data;
  }
}
