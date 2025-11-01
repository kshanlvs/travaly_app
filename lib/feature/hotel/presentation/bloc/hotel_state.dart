part of 'hotel_bloc.dart';

abstract class HotelState {
  const HotelState();
}

class HotelInitial extends HotelState {
  const HotelInitial();
}

class HotelLoading extends HotelState {
  const HotelLoading();
}

class HotelLoaded extends HotelState {
  final List<HotelData> hotels;

  const HotelLoaded(this.hotels);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotelLoaded && listEquals(other.hotels, hotels);
  }

  @override
  int get hashCode => hotels.hashCode;
}

class HotelError extends HotelState {
  final String message;

  const HotelError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotelError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class SearchHotelsLoaded extends HotelState {
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
