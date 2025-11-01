import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:travaly_app/feature/hotel/data/models/hotel_model.dart';
import 'package:travaly_app/feature/hotel/data/repositories/hotel_repositories.dart';
import 'package:travaly_app/feature/hotel/data/repositories/hotel_search_repository.dart';
import 'package:travaly_app/feature/hotel/presentation/bloc/hotel_event.dart';

part 'hotel_state.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  final HotelRepository hotelRepository;
  final HotelSearchRepository hotelSearchRepository;

  HotelBloc(
      {required this.hotelRepository, required this.hotelSearchRepository})
      : super(const HotelInitial()) {
    on<LoadPopularHotelsEvent>(_onLoadPopularHotels);
  }

  Future<void> _onLoadPopularHotels(
    LoadPopularHotelsEvent event,
    Emitter<HotelState> emit,
  ) async {
    emit(const HotelLoading());

    try {
      final List<HotelData> hotels = await hotelRepository.getPopularHotels(
        limit: event.limit,
        entityType: event.entityType,
        searchType: event.searchType,
        searchTypeInfo: event.searchTypeInfo,
        currency: event.currency,
      );
      emit(HotelLoaded(hotels));
    } catch (e) {
      emit(HotelError(e.toString()));
    }
  }
}
