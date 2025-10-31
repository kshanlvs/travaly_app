import 'package:flutter/foundation.dart';









abstract class HotelEvent {
  const HotelEvent();
}

// Event to load popular hotels
class LoadPopularHotelsEvent extends HotelEvent {
  final int limit;
  final String entityType;
  final String searchType;
  final Map<String, dynamic> searchTypeInfo;
  final String currency;

  const LoadPopularHotelsEvent({
    this.limit = 10,
    this.entityType = 'hotel',
    this.searchType = 'byState',
    required this.searchTypeInfo,
    this.currency = 'INR',
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is LoadPopularHotelsEvent &&
        other.limit == limit &&
        other.entityType == entityType &&
        other.searchType == searchType &&
        mapEquals(other.searchTypeInfo, searchTypeInfo) &&
        other.currency == currency;
  }
  
  @override
  int get hashCode {
    return limit.hashCode ^
        entityType.hashCode ^
        searchType.hashCode ^
        searchTypeInfo.hashCode ^
        currency.hashCode;
  }
}

// Event to search hotels
class SearchHotelsEvent extends HotelEvent {
  final String query;

  const SearchHotelsEvent(this.query);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is SearchHotelsEvent &&
        other.query == query;
  }
  
  @override
  int get hashCode => query.hashCode;
}

// Event to clear search and show popular hotels again
class ClearSearchEvent extends HotelEvent {
  const ClearSearchEvent();
}