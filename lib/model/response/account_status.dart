class AccountStatus {
  String? cmd;
  String? oID;
  int? rc;
  String? rs;
  List<Data>? data;

  AccountStatus({this.cmd, this.oID, this.rc, this.rs, this.data});

  AccountStatus.fromJson(Map<String, dynamic> json) {
    cmd = json['cmd'];
    oID = json['oID'];
    rc = json['rc'];
    rs = json['rs'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cmd'] = cmd;
    data['oID'] = oID;
    data['rc'] = rc;
    data['rs'] = rs;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? cashBalance;
  String? debt;
  String? cashAvai;
  String? withdrawalCash;
  String? withdrawalEe;
  String? payment;
  String? tempEe;
  String? apT0;
  String? apT1;
  String? apT2;
  String? arT0;
  String? arT1;
  String? arT2;
  String? collateral;
  String? sellUnmatch;
  String? buyUnmatch;
  String? cashBlock;
  String? sumAp;
  String? withdraw;
  String? depositFee;
  String? tempeeUsed;
  String? tempeeUsing;
  String? assets;
  String? cashAdvanceAvai;
  String? avaiColla;
  String? cashInout;
  String? cashTempDayOut;
  String? vsd;

  Data(
      {this.cashBalance,
      this.debt,
      this.cashAvai,
      this.withdrawalCash,
      this.withdrawalEe,
      this.payment,
      this.tempEe,
      this.apT0,
      this.apT1,
      this.apT2,
      this.arT0,
      this.arT1,
      this.arT2,
      this.collateral,
      this.sellUnmatch,
      this.buyUnmatch,
      this.cashBlock,
      this.sumAp,
      this.withdraw,
      this.depositFee,
      this.tempeeUsed,
      this.tempeeUsing,
      this.assets,
      this.cashAdvanceAvai,
      this.avaiColla,
      this.cashInout,
      this.cashTempDayOut,
      this.vsd});

  Data.fromJson(Map<String, dynamic> json) {
    cashBalance = json['cash_balance'];
    debt = json['debt'];
    cashAvai = json['cash_avai'];
    withdrawalCash = json['withdrawal_cash'];
    withdrawalEe = json['withdrawal_ee'];
    payment = json['payment'];
    tempEe = json['temp_ee'];
    apT0 = json['ap_t0'];
    apT1 = json['ap_t1'];
    apT2 = json['ap_t2'];
    arT0 = json['ar_t0'];
    arT1 = json['ar_t1'];
    arT2 = json['ar_t2'];
    collateral = json['collateral'];
    sellUnmatch = json['sell_unmatch'];
    buyUnmatch = json['buy_unmatch'];
    cashBlock = json['cash_block'];
    sumAp = json['sum_ap'];
    withdraw = json['withdraw'];
    depositFee = json['deposit_fee'];
    tempeeUsed = json['tempee_used'];
    tempeeUsing = json['tempee_using'];
    assets = json['assets'];
    cashAdvanceAvai = json['cash_advance_avai'];
    avaiColla = json['avaiColla'];
    cashInout = json['cash_inout'];
    cashTempDayOut = json['cash_temp_day_out'];
    vsd = json['vsd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cash_balance'] = cashBalance;
    data['debt'] = debt;
    data['cash_avai'] = cashAvai;
    data['withdrawal_cash'] = withdrawalCash;
    data['withdrawal_ee'] = withdrawalEe;
    data['payment'] = payment;
    data['temp_ee'] = tempEe;
    data['ap_t0'] = apT0;
    data['ap_t1'] = apT1;
    data['ap_t2'] = apT2;
    data['ar_t0'] = arT0;
    data['ar_t1'] = arT1;
    data['ar_t2'] = arT2;
    data['collateral'] = collateral;
    data['sell_unmatch'] = sellUnmatch;
    data['buy_unmatch'] = buyUnmatch;
    data['cash_block'] = cashBlock;
    data['sum_ap'] = sumAp;
    data['withdraw'] = withdraw;
    data['deposit_fee'] = depositFee;
    data['tempee_used'] = tempeeUsed;
    data['tempee_using'] = tempeeUsing;
    data['assets'] = assets;
    data['cash_advance_avai'] = cashAdvanceAvai;
    data['avaiColla'] = avaiColla;
    data['cash_inout'] = cashInout;
    data['cash_temp_day_out'] = cashTempDayOut;
    data['vsd'] = vsd;
    return data;
  }
}
