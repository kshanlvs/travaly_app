import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travaly_app/core/constants/app_constants.dart';
import 'package:travaly_app/feature/hotel/data/models/autocomplete_request_model.dart';
import 'package:travaly_app/feature/hotel/data/repositories/hotel_search_repository.dart';
import 'package:travaly_app/feature/hotel/presentation/bloc/search/search_bloc.dart';
import 'package:travaly_app/feature/hotel/presentation/widgets/hotel_search_bar.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppConstants.spacingXXL,
          AppConstants.spacingXXL,
          AppConstants.spacingXXL,
          AppConstants.spacingL,
        ),
        child: HotelAutocompleteSearchBar(
          onSearch: (item) => _handleSearch(context, item),
          onClear: () => {},
          suggestionCallback: (query) async =>
              await _fetchSearchSuggestions(context, query),
        ),
      ),
    );
  }

  Future<List<AutoCompleteItem>> _fetchSearchSuggestions(
      BuildContext context, String query) async {
    try {
      final hotelSearchRepository = context.read<HotelSearchRepository>();
      final response = await hotelSearchRepository.getAutocompleteSuggestions(
        query: query,
        searchTypes: [
          "byCity",
          "byState",
          "byCountry",
          "byRandom",
          "byPropertyName",
        ],
      );

      if (response.status && response.data.present) {
        return response.data.autoCompleteList.allItems;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  void _handleSearch(BuildContext context, AutoCompleteItem item) {
    final searchArray = item.searchArray;
    final queryList = searchArray.query;

    if (queryList.isNotEmpty) {
      final encodedQuery = Uri.encodeComponent(queryList.join(','));
      context.push('/search?q=$encodedQuery');

      context
          .read<SearchBloc>()
          .add(SearchHotelsEvent(searchQuery: encodedQuery));
    }
  }
}
