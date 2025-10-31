import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:travaly_app/feature/hotel/data/models/hotel_model.dart';
import 'package:travaly_app/feature/hotel/data/repositories/hotel_repositories.dart';
import 'package:travaly_app/feature/hotel/presentation/bloc/hotel_event.dart';

part 'hotel_state.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  final HotelRepository hotelRepository;

  HotelBloc({required this.hotelRepository}) : super(const HotelInitial()) {
    on<LoadPopularHotelsEvent>(_onLoadPopularHotels);
    on<SearchHotelsEvent>(_onSearchHotels);
    on<ClearSearchEvent>(_onClearSearch);
  }

  // Handler for loading popular hotels
  Future<void> _onLoadPopularHotels(
    LoadPopularHotelsEvent event,
    Emitter<HotelState> emit,
  ) async {
    // Emit loading state
    emit(const HotelLoading());

    try {
      // Call repository to get data
      final List<HotelData> hotels = await hotelRepository.getPopularHotels(
        limit: event.limit,
        entityType: event.entityType,
        searchType: event.searchType,
        searchTypeInfo: event.searchTypeInfo,
        currency: event.currency,
      );

      // Emit loaded state with data
      emit(HotelLoaded(hotels));
    } catch (e) {
      // Emit error state if something goes wrong
      emit(HotelError(e.toString()));
    }
  }

  // Handler for searching hotels
  Future<void> _onSearchHotels(
    SearchHotelsEvent event,
    Emitter<HotelState> emit,
  ) async {
    // Don't search if query is empty
    if (event.query.isEmpty) {
      add(const ClearSearchEvent());
      return;
    }

    emit(const HotelLoading());

    try {
      // Use the repository method to search
      final List<HotelData> hotels = await hotelRepository.getPopularHotels(
        limit: 10,
        entityType: 'hotel',
        searchType: 'byState',
        searchTypeInfo: {
          'country': 'India',
          'state': 'Jharkhand',
          'city': 'Jamshedpur',
        },
        currency: 'INR',
      );

      // Filter hotels based on search query across multiple fields
      final List<HotelData> filteredHotels = hotels.where((hotel) {
        final String name = hotel.propertyName?.toLowerCase() ?? '';
        final String city = hotel.propertyAddress?.city?.toLowerCase() ?? '';
        final String state = hotel.propertyAddress?.state?.toLowerCase() ?? '';
        final String country =
            hotel.propertyAddress?.country?.toLowerCase() ?? '';
        final String query = event.query.toLowerCase();

        // Search in name, city, state, and country
        return name.contains(query) ||
            city.contains(query) ||
            state.contains(query) ||
            country.contains(query);
      }).toList();

      emit(HotelLoaded(filteredHotels));
    } catch (e) {
      emit(HotelError(e.toString()));
    }
  }

  // Handler for clearing search
  void _onClearSearch(
    ClearSearchEvent event,
    Emitter<HotelState> emit,
  ) {
    // Go back to initial state
    emit(const HotelInitial());
  }
}
