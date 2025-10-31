part of 'hotel_bloc.dart';

abstract class HotelState {
  const HotelState();
}

// Initial state - when the bloc is first created
class HotelInitial extends HotelState {
  const HotelInitial();
}

// Loading state - when data is being fetched
class HotelLoading extends HotelState {
  const HotelLoading();
}

// Loaded state - when data is successfully fetched
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

// Error state - when something goes wrong
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
