// lib/feature/hotel/data/models/search_hotel_model.dart

import 'package:travaly_app/feature/hotel/data/models/hotel_model.dart';

class SearchHotelResponse {
  final bool status;
  final String message;
  final int responseCode;
  final SearchHotelData? data;

  SearchHotelResponse({
    required this.status,
    required this.message,
    required this.responseCode,
    this.data,
  });

  factory SearchHotelResponse.fromJson(Map<String, dynamic> json) {
    return SearchHotelResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      responseCode: json['responseCode'] ?? 0,
      data:
          json['data'] != null ? SearchHotelData.fromJson(json['data']) : null,
    );
  }

  HotelModel toHotelModel() {
    return HotelModel(
      status: status,
      message: message,
      responseCode: responseCode,
      data: data?.arrayOfHotelList?.map((searchHotel) {
        return HotelData(
          propertyName: searchHotel.propertyName,
          propertyStar: searchHotel.propertyStar,
          propertyImage: searchHotel.propertyImage?.fullUrl, // Extract URL
          propertyCode: searchHotel.propertyCode,
          propertyType: searchHotel.propertyType,
          propertyPoliciesAndAmmenities:
              searchHotel.propertyPoliciesAndAmmenities,
          markedPrice: searchHotel.markedPrice,
          googleReview: searchHotel.googleReview,
          propertyUrl: searchHotel.propertyUrl,
          propertyAddress: searchHotel.propertyAddress,
        );
      }).toList(),
    );
  }
}

class SearchHotelData {
  final bool present;
  final int totalNumberOfResult;
  final List<SearchHotel>? arrayOfHotelList;
  final List<String>? arrayOfExcludedHotels;
  final List<String>? arrayOfExcludedSearchType;

  SearchHotelData({
    required this.present,
    required this.totalNumberOfResult,
    this.arrayOfHotelList,
    this.arrayOfExcludedHotels,
    this.arrayOfExcludedSearchType,
  });

  factory SearchHotelData.fromJson(Map<String, dynamic> json) {
    return SearchHotelData(
      present: json['present'] ?? false,
      totalNumberOfResult: json['totalNumberOfResult'] ?? 0,
      arrayOfHotelList: json['arrayOfHotelList'] != null
          ? (json['arrayOfHotelList'] as List)
              .map((v) => SearchHotel.fromJson(v))
              .toList()
          : null,
      arrayOfExcludedHotels: json['arrayOfExcludedHotels'] != null
          ? List<String>.from(json['arrayOfExcludedHotels'])
          : null,
      arrayOfExcludedSearchType: json['arrayOfExcludedSearchType'] != null
          ? List<String>.from(json['arrayOfExcludedSearchType'])
          : null,
    );
  }
}

class SearchHotel {
  final String? propertyCode;
  final String? propertyName;
  final PropertyImage? propertyImage;
  final String? propertyType;
  final int? propertyStar;
  final PropertyPoliciesAndAmmenities? propertyPoliciesAndAmmenities;
  final PropertyAddress? propertyAddress;
  final String? propertyUrl;
  final String? roomName;
  final int? numberOfAdults;
  final MarkedPrice? markedPrice;
  final Price? propertyMaxPrice;
  final Price? propertyMinPrice;
  final List<AvailableDeal>? availableDeals;
  final SubscriptionStatus? subscriptionStatus;
  final int? propertyView;
  final bool? isFavorite;
  final SimplPriceList? simplPriceList;
  final GoogleReview? googleReview;

  SearchHotel({
    this.propertyCode,
    this.propertyName,
    this.propertyImage,
    this.propertyType,
    this.propertyStar,
    this.propertyPoliciesAndAmmenities,
    this.propertyAddress,
    this.propertyUrl,
    this.roomName,
    this.numberOfAdults,
    this.markedPrice,
    this.propertyMaxPrice,
    this.propertyMinPrice,
    this.availableDeals,
    this.subscriptionStatus,
    this.propertyView,
    this.isFavorite,
    this.simplPriceList,
    this.googleReview,
  });

  factory SearchHotel.fromJson(Map<String, dynamic> json) {
    return SearchHotel(
      propertyCode: json['propertyCode'],
      propertyName: json['propertyName'],
      propertyImage: json['propertyImage'] != null
          ? PropertyImage.fromJson(json['propertyImage'])
          : null,
      propertyType: json['propertytype'], // Note the lowercase 't'
      propertyStar: json['propertyStar'],
      propertyPoliciesAndAmmenities:
          json['propertyPoliciesAndAmmenities'] != null
              ? PropertyPoliciesAndAmmenities.fromJson(
                  json['propertyPoliciesAndAmmenities'])
              : null,
      propertyAddress: json['propertyAddress'] != null
          ? PropertyAddress.fromJson(json['propertyAddress'])
          : null,
      propertyUrl: json['propertyUrl'],
      roomName: json['roomName'],
      numberOfAdults: json['numberOfAdults'],
      markedPrice: json['markedPrice'] != null
          ? MarkedPrice.fromJson(json['markedPrice'])
          : null,
      propertyMaxPrice: json['propertyMaxPrice'] != null
          ? Price.fromJson(json['propertyMaxPrice'])
          : null,
      propertyMinPrice: json['propertyMinPrice'] != null
          ? Price.fromJson(json['propertyMinPrice'])
          : null,
      availableDeals: json['availableDeals'] != null
          ? (json['availableDeals'] as List)
              .map((v) => AvailableDeal.fromJson(v))
              .toList()
          : null,
      subscriptionStatus: json['subscriptionStatus'] != null
          ? SubscriptionStatus.fromJson(json['subscriptionStatus'])
          : null,
      propertyView: json['propertyView'],
      isFavorite: json['isFavorite'],
      simplPriceList: json['simplPriceList'] != null
          ? SimplPriceList.fromJson(json['simplPriceList'])
          : null,
      googleReview: json['googleReview'] != null
          ? GoogleReview.fromJson(json['googleReview'])
          : null,
    );
  }
}

// Add these missing models that are in the search response
class PropertyImage {
  final String? fullUrl;
  final String? location;
  final String? imageName;

  PropertyImage({this.fullUrl, this.location, this.imageName});

  factory PropertyImage.fromJson(Map<String, dynamic> json) {
    return PropertyImage(
      fullUrl: json['fullUrl'],
      location: json['location'],
      imageName: json['imageName'],
    );
  }
}

class Price {
  final double? amount;
  final String? displayAmount;
  final String? currencyAmount;
  final String? currencySymbol;

  Price(
      {this.amount,
      this.displayAmount,
      this.currencyAmount,
      this.currencySymbol});

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      amount: json['amount']?.toDouble(),
      displayAmount: json['displayAmount'],
      currencyAmount: json['currencyAmount'],
      currencySymbol: json['currencySymbol'],
    );
  }
}

class AvailableDeal {
  final String? headerName;
  final String? websiteUrl;
  final String? dealType;
  final Price? price;

  AvailableDeal({this.headerName, this.websiteUrl, this.dealType, this.price});

  factory AvailableDeal.fromJson(Map<String, dynamic> json) {
    return AvailableDeal(
      headerName: json['headerName'],
      websiteUrl: json['websiteUrl'],
      dealType: json['dealType'],
      price: json['price'] != null ? Price.fromJson(json['price']) : null,
    );
  }
}

class SubscriptionStatus {
  final bool? status;

  SubscriptionStatus({this.status});

  factory SubscriptionStatus.fromJson(Map<String, dynamic> json) {
    return SubscriptionStatus(
      status: json['status'],
    );
  }
}

class SimplPriceList {
  final Price? simplPrice;
  final double? originalPrice;

  SimplPriceList({this.simplPrice, this.originalPrice});

  factory SimplPriceList.fromJson(Map<String, dynamic> json) {
    return SimplPriceList(
      simplPrice: json['simplPrice'] != null
          ? Price.fromJson(json['simplPrice'])
          : null,
      originalPrice: json['originalPrice']?.toDouble(),
    );
  }
}
