class ImageOrcCheck {
  int? iRs;
  String? sRs;
  OrcDataCheck? data;

  ImageOrcCheck({this.iRs, this.sRs, this.data});

  ImageOrcCheck.fromJson(Map<String, dynamic> json) {
    iRs = json['iRs'];
    sRs = json['sRs'];
    data = json['data'] != null ? OrcDataCheck.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iRs'] = iRs;
    data['sRs'] = sRs;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class OrcDataCheck {
  int? errorCode;
  String? errorMessage;
  List<OrcDataCheck>? data;

  OrcDataCheck({this.errorCode, this.errorMessage, this.data});

  OrcDataCheck.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorMessage = json['errorMessage'];
    if (json['data'] != null) {
      data = <OrcDataCheck>[];
      json['data'].forEach((v) {
        data!.add(OrcDataCheck.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errorCode'] = errorCode;
    data['errorMessage'] = errorMessage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IdentityCard {
  String? id;
  String? idProb;
  String? name;
  String? nameProb;
  String? dob;
  String? dobProb;
  String? sex;
  String? sexProb;
  String? ethnicity;
  String? ethnicityProb;
  String? typeNew;
  String? doe;
  String? doeProb;
  String? home;
  String? homeProb;
  String? address;
  String? addressProb;
  AddressEntities? addressEntities;
  String? overallScore;
  String? type;

  IdentityCard(
      {this.id,
        this.idProb,
        this.name,
        this.nameProb,
        this.dob,
        this.dobProb,
        this.sex,
        this.sexProb,
        this.ethnicity,
        this.ethnicityProb,
        this.typeNew,
        this.doe,
        this.doeProb,
        this.home,
        this.homeProb,
        this.address,
        this.addressProb,
        this.addressEntities,
        this.overallScore,
        this.type});

  IdentityCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idProb = json['id_prob'];
    name = json['name'];
    nameProb = json['name_prob'];
    dob = json['dob'];
    dobProb = json['dob_prob'];
    sex = json['sex'];
    sexProb = json['sex_prob'];
    ethnicity = json['ethnicity'];
    ethnicityProb = json['ethnicity_prob'];
    typeNew = json['type_new'];
    doe = json['doe'];
    doeProb = json['doe_prob'];
    home = json['home'];
    homeProb = json['home_prob'];
    address = json['address'];
    addressProb = json['address_prob'];
    addressEntities = json['address_entities'] != null
        ? AddressEntities.fromJson(json['address_entities'])
        : null;
    overallScore = json['overall_score'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_prob'] = idProb;
    data['name'] = name;
    data['name_prob'] = nameProb;
    data['dob'] = dob;
    data['dob_prob'] = dobProb;
    data['sex'] = sex;
    data['sex_prob'] = sexProb;
    data['ethnicity'] = ethnicity;
    data['ethnicity_prob'] = ethnicityProb;
    data['type_new'] = typeNew;
    data['doe'] = doe;
    data['doe_prob'] = doeProb;
    data['home'] = home;
    data['home_prob'] = homeProb;
    data['address'] = address;
    data['address_prob'] = addressProb;
    if (addressEntities != null) {
      data['address_entities'] = addressEntities!.toJson();
    }
    data['overall_score'] = overallScore;
    data['type'] = type;
    return data;
  }
}

class AddressEntities {
  String? province;
  String? district;
  String? ward;
  String? street;

  AddressEntities({this.province, this.district, this.ward, this.street});

  AddressEntities.fromJson(Map<String, dynamic> json) {
    province = json['province'];
    district = json['district'];
    ward = json['ward'];
    street = json['street'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['province'] = province;
    data['district'] = district;
    data['ward'] = ward;
    data['street'] = street;
    return data;
  }
}


