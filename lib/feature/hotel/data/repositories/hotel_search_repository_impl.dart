import 'package:travaly_app/core/network/network_client.dart';
import 'package:travaly_app/feature/hotel/data/exception/search_exception.dart';
import 'package:travaly_app/feature/hotel/data/models/autocomplete_request_model.dart';
import 'package:travaly_app/feature/hotel/data/models/hotel_model.dart';
import 'package:travaly_app/feature/hotel/data/models/search_request_model.dart';
import 'package:travaly_app/feature/hotel/data/models/search_response_model.dart';
import 'package:travaly_app/feature/hotel/data/repositories/hotel_search_repository.dart';

class HotelSearchRepositoryImpl implements HotelSearchRepository {
  final NetworkClient apiClient;

  HotelSearchRepositoryImpl({required this.apiClient});

  @override
  Future<AutocompleteResponse> getAutocompleteSuggestions({
    required String query,
    required List<String> searchTypes,
    int limit = 10,
  }) async {
    try {
      final request = AutocompleteRequest(
        action: "searchAutoComplete",
        searchAutoComplete: SearchAutoComplete(
          inputText: query,
          searchType: searchTypes,
          limit: limit,
        ),
      );

      final response = await apiClient.post(
        '/public/v1/',
        data: request.toJson(),
      );

      return AutocompleteResponse.fromJson(response);
    } catch (e) {
      throw SearchException(
          'Failed to fetch autocomplete suggestions: ${e.toString()}');
    }
  }

  @override
  Future<HotelModel> getSearchResults({
    required String searchQuery,
    String searchType = "hotelIdSearch",
    int limit = 5,
  }) async {
    try {
      final request = SearchRequest(
        action: "getSearchResultListOfHotels",
        getSearchResultListOfHotels: GetSearchResultListOfHotels(
          searchCriteria: SearchCriteria.basic(
            searchQuery: [searchQuery],
            searchType: searchType,
            limit: limit,
          ),
        ),
      );

      final response = await apiClient.post(
        '/public/v1/',
        data: request.toJson(),
      );

      // Convert search response to your existing HotelModel
      final searchResponse = SearchHotelResponse.fromJson(response);
      return searchResponse.toHotelModel();
    } catch (e) {
      throw SearchException('Failed to fetch search results: ${e.toString()}');
    }
  }
}
