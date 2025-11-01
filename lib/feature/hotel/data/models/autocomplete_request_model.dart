// lib/feature/hotel/data/models/autocomplete_model.dart

import 'package:flutter/material.dart';

class AutocompleteRequest {
  final String action;
  final SearchAutoComplete searchAutoComplete;

  AutocompleteRequest({
    required this.action,
    required this.searchAutoComplete,
  });

  Map<String, dynamic> toJson() => {
        "action": action,
        "searchAutoComplete": searchAutoComplete.toJson(),
      };
}

class SearchAutoComplete {
  final String inputText;
  final List<String> searchType;
  final int limit;

  SearchAutoComplete({
    required this.inputText,
    required this.searchType,
    this.limit = 10,
  });

  Map<String, dynamic> toJson() => {
        "inputText": inputText,
        "searchType": searchType,
        "limit": limit,
      };
}

class AutocompleteResponse {
  final bool status;
  final String message;
  final int responseCode;
  final AutocompleteData data;

  AutocompleteResponse({
    required this.status,
    required this.message,
    required this.responseCode,
    required this.data,
  });

  factory AutocompleteResponse.fromJson(Map<String, dynamic> json) {
    return AutocompleteResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      responseCode: json['responseCode'] ?? 0,
      data: AutocompleteData.fromJson(json['data'] ?? {}),
    );
  }
}

class AutocompleteData {
  final bool present;
  final int totalNumberOfResult;
  final AutoCompleteList autoCompleteList;

  AutocompleteData({
    required this.present,
    required this.totalNumberOfResult,
    required this.autoCompleteList,
  });

  factory AutocompleteData.fromJson(Map<String, dynamic> json) {
    return AutocompleteData(
      present: json['present'] ?? false,
      totalNumberOfResult: json['totalNumberOfResult'] ?? 0,
      autoCompleteList:
          AutoCompleteList.fromJson(json['autoCompleteList'] ?? {}),
    );
  }
}

class AutoCompleteList {
  final List<AutoCompleteItem> byPropertyName;
  final List<AutoCompleteItem> byStreet;
  final List<AutoCompleteItem> byCity;
  final List<AutoCompleteItem> byState;
  final List<AutoCompleteItem> byCountry;

  AutoCompleteList({
    required this.byPropertyName,
    required this.byStreet,
    required this.byCity,
    required this.byState,
    required this.byCountry,
  });

  factory AutoCompleteList.fromJson(Map<String, dynamic> json) {
    return AutoCompleteList(
      byPropertyName: _parseList(json['byPropertyName']?['listOfResult']),
      byStreet: _parseList(json['byStreet']?['listOfResult']),
      byCity: _parseList(json['byCity']?['listOfResult']),
      byState: _parseList(json['byState']?['listOfResult']),
      byCountry: _parseList(json['byCountry']?['listOfResult']),
    );
  }

  static List<AutoCompleteItem> _parseList(List<dynamic>? list) {
    if (list == null) return [];
    return list.map((item) => AutoCompleteItem.fromJson(item)).toList();
  }

  // Get all items as a flat list
  List<AutoCompleteItem> get allItems {
    return [
      ...byPropertyName,
      ...byStreet,
      ...byCity,
      ...byState,
      ...byCountry,
    ];
  }

  // Get items grouped by type
  Map<String, List<AutoCompleteItem>> get groupedItems {
    return {
      'Hotels': byPropertyName,
      'Streets': byStreet,
      'Cities': byCity,
      'States': byState,
      'Countries': byCountry,
    };
  }
}

class AutoCompleteItem {
  final String valueToDisplay;
  final String? propertyName;
  final Address? address;
  final SearchArray searchArray;

  AutoCompleteItem({
    required this.valueToDisplay,
    this.propertyName,
    this.address,
    required this.searchArray,
  });

  factory AutoCompleteItem.fromJson(Map<String, dynamic> json) {
    return AutoCompleteItem(
      valueToDisplay: json['valueToDisplay'] ?? '',
      propertyName: json['propertyName'],
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
      searchArray: SearchArray.fromJson(json['searchArray'] ?? {}),
    );
  }

  String get displayText {
    return valueToDisplay;
  }

  String get type {
    return searchArray.type.replaceAll('Search', '').toTitleCase;
  }

  IconData get icon {
    switch (searchArray.type) {
      case 'hotelIdSearch':
        return Icons.hotel;
      case 'streetSearch':
        return Icons.location_on;
      case 'citySearch':
        return Icons.location_city;
      case 'stateSearch':
        return Icons.map;
      case 'countrySearch':
        return Icons.public;
      default:
        return Icons.search;
    }
  }

  Color get iconColor {
    switch (searchArray.type) {
      case 'hotelIdSearch':
        return const Color(0xFF4F46E5);
      case 'streetSearch':
        return const Color(0xFF059669);
      case 'citySearch':
        return const Color(0xFFDC2626);
      case 'stateSearch':
        return const Color(0xFF7C3AED);
      case 'countrySearch':
        return const Color(0xFFEA580C);
      default:
        return const Color(0xFF6B7280);
    }
  }
}

class Address {
  final String? street;
  final String? city;
  final String? state;
  final String? country;

  Address({
    this.street,
    this.city,
    this.state,
    this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
    );
  }

  String get formattedAddress {
    final parts = [street, city, state, country]
        .where((part) => part != null)
        .cast<String>();
    return parts.join(', ');
  }
}

class SearchArray {
  final String type;
  final List<String> query;

  SearchArray({
    required this.type,
    required this.query,
  });

  factory SearchArray.fromJson(Map<String, dynamic> json) {
    return SearchArray(
      type: json['type'] ?? '',
      query: List<String>.from(json['query'] ?? []),
    );
  }
}

// Extension for string title case
extension StringExtension on String {
  String get toTitleCase {
    if (isEmpty) return this;
    return split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
}
