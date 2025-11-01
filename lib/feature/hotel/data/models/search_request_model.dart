class SearchRequest {
  final String action;
  final GetSearchResultListOfHotels getSearchResultListOfHotels;

  SearchRequest({
    required this.action,
    required this.getSearchResultListOfHotels,
  });

  Map<String, dynamic> toJson() => {
        "action": action,
        "getSearchResultListOfHotels": getSearchResultListOfHotels.toJson(),
      };
}

class GetSearchResultListOfHotels {
  final SearchCriteria searchCriteria;

  GetSearchResultListOfHotels({
    required this.searchCriteria,
  });

  Map<String, dynamic> toJson() => {
        "searchCriteria": searchCriteria.toJson(),
      };
}

class SearchCriteria {
  final String checkIn;
  final String checkOut;
  final int rooms;
  final int adults;
  final int children;
  final String searchType;
  final List<String> searchQuery;
  final List<String> accommodation;
  final List<String> arrayOfExcludedSearchType;
  final String highPrice;
  final String lowPrice;
  final int limit;
  final List<dynamic> preloaderList;
  final String currency;
  final int rid;

  SearchCriteria({
    required this.checkIn,
    required this.checkOut,
    required this.rooms,
    required this.adults,
    required this.children,
    required this.searchType,
    required this.searchQuery,
    required this.accommodation,
    required this.arrayOfExcludedSearchType,
    required this.highPrice,
    required this.lowPrice,
    required this.limit,
    required this.preloaderList,
    required this.currency,
    required this.rid,
  });

  Map<String, dynamic> toJson() => {
        "checkIn": checkIn,
        "checkOut": checkOut,
        "rooms": rooms,
        "adults": adults,
        "children": children,
        "searchType": searchType,
        "searchQuery": searchQuery,
        "accommodation": accommodation,
        "arrayOfExcludedSearchType": arrayOfExcludedSearchType,
        "highPrice": highPrice,
        "lowPrice": lowPrice,
        "limit": 5,
        "preloaderList": preloaderList,
        "currency": currency,
        "rid": rid,
      };

  factory SearchCriteria.basic({
    required List<String> searchQuery,
    String searchType = "hotelIdSearch",
    int limit = 5,
  }) {
    final checkInDate = DateTime(2026, 1, 15);
    final checkOutDate = checkInDate.add(const Duration(days: 1));

    return SearchCriteria(
      checkIn: _formatDate(checkInDate),
      checkOut: _formatDate(checkOutDate),
      rooms: 1,
      adults: 2,
      children: 0,
      searchType: searchType,
      searchQuery: searchQuery,
      accommodation: ["all", "hotel"],
      arrayOfExcludedSearchType: ["street"],
      highPrice: "3000000",
      lowPrice: "0",
      limit: limit,
      preloaderList: [],
      currency: "INR",
      rid: 2,
    );
  }

  static String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString()
    .padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }
}
