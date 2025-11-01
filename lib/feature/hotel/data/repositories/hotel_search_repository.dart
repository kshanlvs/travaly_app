import 'package:travaly_app/feature/hotel/data/models/autocomplete_request_model.dart';
import 'package:travaly_app/feature/hotel/data/models/hotel_model.dart';

abstract class HotelSearchRepository {
  Future<AutocompleteResponse> getAutocompleteSuggestions({
    required String query,
    required List<String> searchTypes,
    int limit = 10,
  });

  Future<HotelModel> getSearchResults({
    required String searchQuery,
    String searchType = "byPropertyName",
    int limit = 5,
  });
}
