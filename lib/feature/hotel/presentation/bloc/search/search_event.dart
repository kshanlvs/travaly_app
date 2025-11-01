part of 'search_bloc.dart';

abstract class SearchEvent {
  const SearchEvent();
}

class SearchHotelsEvent extends SearchEvent {
  final String searchQuery;
  final String? searchType;
  final int limit;

  const SearchHotelsEvent({
    required this.searchQuery,
    this.searchType,
    this.limit = 20,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchHotelsEvent &&
        other.searchQuery == searchQuery &&
        other.searchType == searchType &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    return searchQuery.hashCode ^ searchType.hashCode ^ limit.hashCode;
  }
}

class ClearSearchEvent extends SearchEvent {
  const ClearSearchEvent();

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is ClearSearchEvent;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}
