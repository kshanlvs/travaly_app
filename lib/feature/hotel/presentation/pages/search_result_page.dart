// lib/feature/hotel/presentation/pages/search_results_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travaly_app/core/constants/app_constants.dart';
import 'package:travaly_app/feature/hotel/data/models/hotel_model.dart';
import 'package:travaly_app/feature/hotel/data/repositories/hotel_search_repository.dart';
import 'package:travaly_app/feature/hotel/presentation/bloc/search/search_bloc.dart';

import 'package:travaly_app/feature/hotel/presentation/widgets/hotel_card.dart';

class SearchResultsPage extends StatelessWidget {
  final String searchQuery;

  const SearchResultsPage({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(
        hotelSearchRepository: context.read<HotelSearchRepository>(),
      )..add(SearchHotelsEvent(searchQuery: searchQuery)),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: AppBar(
          title: const Text(
            'Search Results',
            style: TextStyle(
              fontSize: AppConstants.fontSizeXL,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          backgroundColor: AppColors.cardBackground,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColors.textPrimary,
              size: AppConstants.iconSizeM,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return _buildContent(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, SearchState state) {
    return switch (state) {
      SearchLoading() => _buildLoadingState(),
      SearchError(:final message) => _buildErrorState(message, context),
      SearchHotelsLoaded(:final hotels) => _buildResultsList(hotels),
      _ => _buildInitialState(),
    };
  }

  Widget _buildInitialState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_rounded,
            size: AppConstants.iconSizeXL * 2,
            color: AppColors.textHint,
          ),
          SizedBox(height: AppConstants.spacingL),
          Text(
            'Searching...',
            style: TextStyle(
              fontSize: AppConstants.fontSizeL,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorState(String message, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingXXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: AppConstants.iconSizeXL * 2,
              color: AppColors.errorColor,
            ),
            const SizedBox(height: AppConstants.spacingL),
            const Text(
              'Search Failed',
              style: TextStyle(
                fontSize: AppConstants.fontSizeL,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppConstants.spacingM),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: AppConstants.fontSizeM,
                color: AppColors.textHint,
              ),
            ),
            const SizedBox(height: AppConstants.spacingXL),
            ElevatedButton(
              onPressed: () {
                context.read<SearchBloc>().add(SearchHotelsEvent(
                      searchQuery: searchQuery,
                    ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppConstants.borderRadiusL),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingXL,
                  vertical: AppConstants.spacingM,
                ),
              ),
              child: const Text(
                'Try Again',
                style: TextStyle(
                  fontSize: AppConstants.fontSizeM,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsList(List<HotelData> hotels) {
    if (hotels.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Results header
        Padding(
          padding: const EdgeInsets.all(AppConstants.spacingL),
          child: Row(
            children: [
              Text(
                'Found ${hotels.length} hotels',
                style: const TextStyle(
                  fontSize: AppConstants.fontSizeM,
                  color: AppColors.textHint,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: AppConstants.spacingS),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingM,
                  vertical: AppConstants.spacingXS,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(AppConstants.borderRadiusM),
                ),
                child: Text(
                  '"$searchQuery"',
                  style: const TextStyle(
                    fontSize: AppConstants.fontSizeS,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Hotels list
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacingL,
              vertical: AppConstants.spacingS,
            ),
            itemCount: hotels.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppConstants.spacingL),
            itemBuilder: (context, index) {
              return HotelCard(hotel: hotels[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingXXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.hotel_rounded,
              size: AppConstants.iconSizeXL * 2,
              color: AppColors.textHint,
            ),
            const SizedBox(height: AppConstants.spacingL),
            const Text(
              'No hotels found',
              style: TextStyle(
                fontSize: AppConstants.fontSizeL,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppConstants.spacingM),
            const Text(
              'Try adjusting your search criteria',
              style: TextStyle(
                fontSize: AppConstants.fontSizeM,
                color: AppColors.textHint,
              ),
            ),
            const SizedBox(height: AppConstants.spacingM),
            Text(
              'Search: "$searchQuery"',
              style: const TextStyle(
                fontSize: AppConstants.fontSizeS,
                color: AppColors.textHint,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
