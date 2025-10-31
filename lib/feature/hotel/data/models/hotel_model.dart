class HotelModel {
  bool? status;
  String? message;
  int? responseCode;
  List<HotelData>? data;

  HotelModel({this.status, this.message, this.responseCode, this.data});

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      status: json['status'],
      message: json['message'],
      responseCode: json['responseCode'],
      data: json['data'] != null
          ? (json['data'] as List).map((v) => HotelData.fromJson(v)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['responseCode'] = responseCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HotelData {
  String? propertyName;
  int? propertyStar;
  String? propertyImage;
  String? propertyCode;
  String? propertyType;
  PropertyPoliciesAndAmmenities? propertyPoliciesAndAmmenities;
  MarkedPrice? markedPrice;
  StaticPrice? staticPrice;
  GoogleReview? googleReview;
  String? propertyUrl;
  PropertyAddress? propertyAddress;

  HotelData({
    this.propertyName,
    this.propertyStar,
    this.propertyImage,
    this.propertyCode,
    this.propertyType,
    this.propertyPoliciesAndAmmenities,
    this.markedPrice,
    this.staticPrice,
    this.googleReview,
    this.propertyUrl,
    this.propertyAddress,
  });

  factory HotelData.fromJson(Map<String, dynamic> json) {
    return HotelData(
      propertyName: json['propertyName'],
      propertyStar: json['propertyStar'],
      propertyImage: json['propertyImage'],
      propertyCode: json['propertyCode'],
      propertyType: json['propertyType'],
      propertyPoliciesAndAmmenities: json['propertyPoliciesAndAmmenities'] != null
          ? PropertyPoliciesAndAmmenities.fromJson(json['propertyPoliciesAndAmmenities'])
          : null,
      markedPrice: json['markedPrice'] != null
          ? MarkedPrice.fromJson(json['markedPrice'])
          : null,
      staticPrice: json['staticPrice'] != null
          ? StaticPrice.fromJson(json['staticPrice'])
          : null,
      googleReview: json['googleReview'] != null
          ? GoogleReview.fromJson(json['googleReview'])
          : null,
      propertyUrl: json['propertyUrl'],
      propertyAddress: json['propertyAddress'] != null
          ? PropertyAddress.fromJson(json['propertyAddress'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['propertyName'] = propertyName;
    data['propertyStar'] = propertyStar;
    data['propertyImage'] = propertyImage;
    data['propertyCode'] = propertyCode;
    data['propertyType'] = propertyType;
    if (propertyPoliciesAndAmmenities != null) {
      data['propertyPoliciesAndAmmenities'] = propertyPoliciesAndAmmenities!.toJson();
    }
    if (markedPrice != null) {
      data['markedPrice'] = markedPrice!.toJson();
    }
    if (staticPrice != null) {
      data['staticPrice'] = staticPrice!.toJson();
    }
    if (googleReview != null) {
      data['googleReview'] = googleReview!.toJson();
    }
    data['propertyUrl'] = propertyUrl;
    if (propertyAddress != null) {
      data['propertyAddress'] = propertyAddress!.toJson();
    }
    return data;
  }
}

class PropertyPoliciesAndAmmenities {
  bool? present;
  PoliciesData? data;

  PropertyPoliciesAndAmmenities({this.present, this.data});

  factory PropertyPoliciesAndAmmenities.fromJson(Map<String, dynamic> json) {
    return PropertyPoliciesAndAmmenities(
      present: json['present'],
      data: json['data'] != null ? PoliciesData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['present'] = present;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PoliciesData {
  String? cancelPolicy;
  String? refundPolicy;
  String? childPolicy;
  String? damagePolicy;
  String? propertyRestriction;
  bool? petsAllowed;
  bool? coupleFriendly;
  bool? suitableForChildren;
  bool? bachularsAllowed;
  bool? freeWifi;
  bool? freeCancellation;
  bool? payAtHotel;
  bool? payNow;
  String? lastUpdatedOn;

  PoliciesData({
    this.cancelPolicy,
    this.refundPolicy,
    this.childPolicy,
    this.damagePolicy,
    this.propertyRestriction,
    this.petsAllowed,
    this.coupleFriendly,
    this.suitableForChildren,
    this.bachularsAllowed,
    this.freeWifi,
    this.freeCancellation,
    this.payAtHotel,
    this.payNow,
    this.lastUpdatedOn,
  });

  factory PoliciesData.fromJson(Map<String, dynamic> json) {
    return PoliciesData(
      cancelPolicy: json['cancelPolicy'],
      refundPolicy: json['refundPolicy'],
      childPolicy: json['childPolicy'],
      damagePolicy: json['damagePolicy'],
      propertyRestriction: json['propertyRestriction'],
      petsAllowed: json['petsAllowed'],
      coupleFriendly: json['coupleFriendly'],
      suitableForChildren: json['suitableForChildren'],
      bachularsAllowed: json['bachularsAllowed'],
      freeWifi: json['freeWifi'],
      freeCancellation: json['freeCancellation'],
      payAtHotel: json['payAtHotel'],
      payNow: json['payNow'],
      lastUpdatedOn: json['lastUpdatedOn'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cancelPolicy'] = cancelPolicy;
    data['refundPolicy'] = refundPolicy;
    data['childPolicy'] = childPolicy;
    data['damagePolicy'] = damagePolicy;
    data['propertyRestriction'] = propertyRestriction;
    data['petsAllowed'] = petsAllowed;
    data['coupleFriendly'] = coupleFriendly;
    data['suitableForChildren'] = suitableForChildren;
    data['bachularsAllowed'] = bachularsAllowed;
    data['freeWifi'] = freeWifi;
    data['freeCancellation'] = freeCancellation;
    data['payAtHotel'] = payAtHotel;
    data['payNow'] = payNow;
    data['lastUpdatedOn'] = lastUpdatedOn;
    return data;
  }
}

class MarkedPrice {
  double? amount;
  String? displayAmount;
  String? currencyAmount;
  String? currencySymbol;

  MarkedPrice({
    this.amount,
    this.displayAmount,
    this.currencyAmount,
    this.currencySymbol,
  });

  factory MarkedPrice.fromJson(Map<String, dynamic> json) {
    return MarkedPrice(
      amount: json['amount']?.toDouble(),
      displayAmount: json['displayAmount'],
      currencyAmount: json['currencyAmount'],
      currencySymbol: json['currencySymbol'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['displayAmount'] = displayAmount;
    data['currencyAmount'] = currencyAmount;
    data['currencySymbol'] = currencySymbol;
    return data;
  }
}

class StaticPrice {
  int? amount;
  String? displayAmount;
  String? currencyAmount;
  String? currencySymbol;

  StaticPrice({
    this.amount,
    this.displayAmount,
    this.currencyAmount,
    this.currencySymbol,
  });

  factory StaticPrice.fromJson(Map<String, dynamic> json) {
    return StaticPrice(
      amount: json['amount'],
      displayAmount: json['displayAmount'],
      currencyAmount: json['currencyAmount'],
      currencySymbol: json['currencySymbol'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['displayAmount'] = displayAmount;
    data['currencyAmount'] = currencyAmount;
    data['currencySymbol'] = currencySymbol;
    return data;
  }
}

class GoogleReview {
  bool? reviewPresent;
  ReviewData? data;

  GoogleReview({this.reviewPresent, this.data});

  factory GoogleReview.fromJson(Map<String, dynamic> json) {
    return GoogleReview(
      reviewPresent: json['reviewPresent'],
      data: json['data'] != null ? ReviewData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reviewPresent'] = reviewPresent;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ReviewData {
  double? overallRating;
  int? totalUserRating;
  int? withoutDecimal;

  ReviewData({
    this.overallRating,
    this.totalUserRating,
    this.withoutDecimal,
  });

  factory ReviewData.fromJson(Map<String, dynamic> json) {
    return ReviewData(
      overallRating: json['overallRating']?.toDouble(),
      totalUserRating: json['totalUserRating'],
      withoutDecimal: json['withoutDecimal'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['overallRating'] = overallRating;
    data['totalUserRating'] = totalUserRating;
    data['withoutDecimal'] = withoutDecimal;
    return data;
  }
}

class PropertyAddress {
  String? street;
  String? city;
  String? state;
  String? country;
  String? zipcode;
  String? mapAddress;
  double? latitude;
  double? longitude;

  PropertyAddress({
    this.street,
    this.city,
    this.state,
    this.country,
    this.zipcode,
    this.mapAddress,
    this.latitude,
    this.longitude,
  });

  factory PropertyAddress.fromJson(Map<String, dynamic> json) {
    return PropertyAddress(
      street: json['street'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      zipcode: json['zipcode'],
      mapAddress: json['map_address'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street'] = street;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['zipcode'] = zipcode;
    data['map_address'] = mapAddress;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}