import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travaly_app/core/constants/app_constants.dart';
import 'package:travaly_app/feature/hotel/data/models/hotel_model.dart';
import 'package:travaly_app/feature/hotel/presentation/bloc/hotel_bloc.dart';
import 'package:travaly_app/feature/hotel/presentation/bloc/hotel_event.dart';
import 'package:travaly_app/feature/hotel/presentation/widgets/hotel_card.dart';
import 'package:travaly_app/feature/hotel/presentation/widgets/hotel_card_shimmer.dart';
import 'package:travaly_app/feature/hotel/presentation/widgets/hotel_error_widget.dart';
import 'package:travaly_app/feature/hotel/presentation/widgets/empty_hotel_state.dart';

class HotelListSection extends StatelessWidget {
  const HotelListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelBloc, HotelState>(
      builder: (context, state) {
        return switch (state) {
          HotelLoading() => const SliverToBoxAdapter(child: HotelListShimmer()),
          HotelError(:final message) => SliverToBoxAdapter(
              child: HotelErrorWidget(
                message: message,
                onRetry: () => _retryLoadHotels(context),
              ),
            ),
          HotelLoaded(:final hotels) => _buildHotelList(hotels),
          _ => const SliverToBoxAdapter(child: HotelListShimmer()),
        };
      },
    );
  }

  Widget _buildHotelList(List<HotelData> hotels) {
    if (hotels.isEmpty) {
      return const SliverToBoxAdapter(child: EmptyHotelState());
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.only(
              top: AppConstants.spacingL,
              left: AppConstants.spacingXXL,
              right: AppConstants.spacingXXL,
              bottom: AppConstants.spacingL),
          child: HotelCard(hotel: hotels[index]),
        ),
        childCount: hotels.length,
      ),
    );
  }

  void _retryLoadHotels(BuildContext context) {
    context.read<HotelBloc>().add(
          const LoadPopularHotelsEvent(
            searchTypeInfo: {
              'country': 'India',
              'state': 'Jharkhand',
              'city': 'Jamshedpur',
            },
          ),
        );
  }
}

class HotelListShimmer extends StatelessWidget {
  const HotelListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (index) => const Padding(
          padding: const EdgeInsets.only(
              top: AppConstants.spacingL,
              left: AppConstants.spacingXXL,
              right: AppConstants.spacingXXL,
              bottom: AppConstants.spacingL),
          child: HotelCardShimmer(),
        ),
      ),
    );
  }
}
