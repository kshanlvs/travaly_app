import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travaly_app/feature/hotel/data/models/hotel_model.dart';
import 'package:travaly_app/feature/hotel/data/repositories/hotel_search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final HotelSearchRepository hotelSearchRepository;

  SearchBloc({required this.hotelSearchRepository})
      : super(const SearchInitial()) {
    on<SearchHotelsEvent>(_onSearchHotels);
    on<ClearSearchEvent>(_onClearSearch);
  }

  Future<void> _onSearchHotels(
    SearchHotelsEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(const SearchLoading());
    try {
      // Map autocomplete search types to search API search types
      final mappedSearchType = _mapSearchType(event.searchType);

      final hotelModel = await hotelSearchRepository.getSearchResults(
        searchQuery: event.searchQuery,
        searchType: mappedSearchType, // Use mapped type
        limit: event.limit,
      );

      if (hotelModel.status == true && hotelModel.data != null) {
        emit(SearchHotelsLoaded(
          hotels: hotelModel.data!,
          searchQuery: event.searchQuery,
        ));
      } else {
        emit(SearchError(hotelModel.message ?? 'Search failed'));
      }
    } catch (e) {
      emit(SearchError('Failed to search hotels: ${e.toString()}'));
    }
  }

  // Map autocomplete search types to search API search types
  String _mapSearchType(String? autocompleteType) {
    switch (autocompleteType) {
      case 'byPropertyName':
        return 'hotelIdSearch';
      case 'byStreet':
        return 'streetSearch';
      case 'byCity':
        return 'citySearch';
      case 'byState':
        return 'stateSearch';
      case 'byCountry':
        return 'countrySearch';
      case 'byRandom':
        return 'searchByKeywords';
      default:
        return 'hotelIdSearch';
    }
  }

  void _onClearSearch(
    ClearSearchEvent event,
    Emitter<SearchState> emit,
  ) {
    emit(const SearchInitial());
  }
}
