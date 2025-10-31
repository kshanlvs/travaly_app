class PopularStayRequest {
  final String action;
  final PopularStay popularStay;

  PopularStayRequest({
    required this.action,
    required this.popularStay,
  });

  Map<String, dynamic> toJson() {
    return {
      'action': action,
      'popularStay': popularStay.toJson(),
    };
  }
}

class PopularStay {
  final int limit;
  final String entityType;
  final Filter filter;
  final String currency;

  PopularStay({
    required this.limit,
    required this.entityType,
    required this.filter,
    required this.currency,
  });

  Map<String, dynamic> toJson() {
    return {
      'limit': limit,
      'entityType': entityType,
      'filter': filter.toJson(),
      'currency': currency,
    };
  }
}

class Filter {
  final String searchType;
  final SearchTypeInfo searchTypeInfo;

  Filter({
    required this.searchType,
    required this.searchTypeInfo,
  });

  Map<String, dynamic> toJson() {
    return {
      'searchType': searchType,
      'searchTypeInfo': searchTypeInfo.toJson(),
    };
  }
}

class SearchTypeInfo {
  final String country;
  final String state;
  final String city;

  SearchTypeInfo({
    required this.country,
    required this.state,
    required this.city,
  });

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'state': state,
      'city': city,
    };
  }
}
