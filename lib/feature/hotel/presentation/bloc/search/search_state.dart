part of 'search_bloc.dart';

abstract class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {
  const SearchInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is SearchInitial;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

class SearchLoading extends SearchState {
  const SearchLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is SearchLoading;
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

class SearchHotelsLoaded extends SearchState {
  final List<HotelData> hotels;
  final String searchQuery;

  const SearchHotelsLoaded({
    required this.hotels,
    required this.searchQuery,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchHotelsLoaded &&
        listEquals(other.hotels, hotels) &&
        other.searchQuery == searchQuery;
  }

  @override
  int get hashCode {
    return hotels.hashCode ^ searchQuery.hashCode;
  }
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SearchError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
