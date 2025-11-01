import 'package:flutter/material.dart';
import 'package:travaly_app/core/constants/app_constants.dart';
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
        child:  HotelSearchBar(onClear: () {
          
        },onSearch: (p0) {
          
        },),
      ),
    );
  }
}