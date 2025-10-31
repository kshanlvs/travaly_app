import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travaly_app/core/dependency_injection/service_locator.dart';
import 'package:travaly_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:travaly_app/feature/hotel/data/models/hotel_model.dart';
import 'package:travaly_app/feature/hotel/data/repositories/hotel_repositories.dart';
import 'package:travaly_app/feature/hotel/presentation/bloc/hotel_bloc.dart';
import 'package:travaly_app/feature/hotel/presentation/bloc/hotel_event.dart';
import 'package:travaly_app/feature/hotel/presentation/widgets/hotel_card.dart';
import 'package:travaly_app/feature/hotel/presentation/widgets/hotel_card_shimmer.dart';
import 'package:travaly_app/core/constants/app_constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoggedOut) context.go('/login');
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: BlocProvider(
          create: (context) => HotelBloc(hotelRepository: sl<HotelRepository>())
            ..add(
              const LoadPopularHotelsEvent(
                searchTypeInfo: {
                  'country': 'India',
                  'state': 'Jharkhand',
                  'city': 'Jamshedpur',
                },
              ),
            ),
          child: const _HomeContent(),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: AppConstants.cardElevationL,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingXXXL,
            vertical: AppConstants.spacingL,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(Icons.home_filled, AppText.home, isActive: true),
              _buildNavItem(Icons.bookmark, AppText.book),
              _buildNavItem(Icons.card_travel, AppText.trips),
              _buildNavItem(Icons.person, AppText.profile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, {bool isActive = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? AppColors.primaryColor : AppColors.gray500,
          size: AppConstants.iconSizeL,
        ),
        const SizedBox(height: AppConstants.spacingXS),
        Text(
          label,
          style: TextStyle(
            fontSize: AppConstants.fontSizeS,
            color: isActive ? AppColors.primaryColor : AppColors.gray500,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // Header Section
        SliverAppBar(
          backgroundColor: AppColors.scaffoldBackground,
          expandedHeight: AppConstants.imageHeightXL,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primaryDark, AppColors.primaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingXXL,
                vertical: AppConstants.spacingXXXL,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppText.yourGatewayTo,
                    style: TextStyle(
                      color: AppColors.white.withOpacity(0.7),
                      fontSize: AppConstants.fontSizeL,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingXS),
                  const Text(
                    AppText.luxuryHotel,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: AppConstants.fontSizeDisplayS,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingL),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppText.goodMorning,
                            style: TextStyle(
                              color: AppColors.white.withOpacity(0.7),
                              fontSize: AppConstants.fontSizeM,
                            ),
                          ),
                          const SizedBox(height: AppConstants.spacingXS),
                          const Text(
                            'Dr Hohn Deo',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: AppConstants.fontSizeXL,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.logout, color: AppColors.white),
                        tooltip: AppText.logout,
                        onPressed: () => _showLogoutDialog(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // Search Section
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppConstants.spacingXXL,
              AppConstants.spacingXXL,
              AppConstants.spacingXXL,
              AppConstants.spacingL,
            ),
            child: Material(
              elevation: AppConstants.cardElevationL,
              shadowColor: AppColors.black.withOpacity(0.26),
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
              child: TextField(
                decoration: InputDecoration(
                  hintText: AppText.searchYourHotel,
                  hintStyle: const TextStyle(color: AppColors.textHint),
                  filled: true,
                  fillColor: AppColors.cardBackground,
                  prefixIcon:
                      const Icon(Icons.search, color: AppColors.textHint),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(AppConstants.borderRadiusL),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: AppConstants.spacingL,
                    horizontal: AppConstants.spacingXL,
                  ),
                ),
              ),
            ),
          ),
        ),

        // Hotels List Section
        const SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.spacingXXL,
            vertical: AppConstants.spacingL,
          ),
          sliver: _HotelListSection(),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusL),
        ),
        title: const Text(
          AppText.logout,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: AppConstants.fontSizeXL,
          ),
        ),
        content: const Text(AppText.confirmLogout),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppText.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.errorColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthBloc>().add(SignOutEvent());
            },
            child: const Text(AppText.logout),
          ),
        ],
      ),
    );
  }
}

class _HotelListSection extends StatelessWidget {
  const _HotelListSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelBloc, HotelState>(
      builder: (context, state) {
        return switch (state) {
          HotelLoading() =>
            const SliverToBoxAdapter(child: _HotelListShimmer()),
          HotelError(:final message) => SliverToBoxAdapter(
              child: _buildError(message, context),
            ),
          HotelLoaded(:final hotels) => _buildList(hotels),
          _ => const SliverToBoxAdapter(
              child: _HotelListShimmer(),
            ),
        };
      },
    );
  }

  Widget _buildList(List<HotelData> hotels) {
    if (hotels.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(AppConstants.spacingXXL),
            child: Text(
              AppText.noHotelsFound,
              style: TextStyle(
                fontSize: AppConstants.fontSizeL,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: AppConstants.spacingL),
          child: HotelCard(hotel: hotels[index]),
        ),
        childCount: hotels.length,
      ),
    );
  }

  Widget _buildError(String message, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingXXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: AppConstants.iconSizeXXL * 2,
              color: AppColors.errorColor,
            ),
            const SizedBox(height: AppConstants.spacingL),
            Text(
              AppText.somethingWentWrong,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: AppConstants.fontSizeXL,
                  ),
            ),
            const SizedBox(height: AppConstants.spacingM),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: AppConstants.fontSizeM,
              ),
            ),
            const SizedBox(height: AppConstants.spacingL),
            ElevatedButton.icon(
              onPressed: () {
                context.read<HotelBloc>().add(
                      const LoadPopularHotelsEvent(
                        searchTypeInfo: {
                          'country': 'India',
                          'state': 'Jharkhand',
                          'city': 'Jamshedpur',
                        },
                      ),
                    );
              },
              icon: const Icon(Icons.refresh, size: AppConstants.iconSizeM),
              label: const Text(AppText.retry),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.infoColor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppConstants.borderRadiusM),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HotelListShimmer extends StatelessWidget {
  const _HotelListShimmer();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3, // Show 3 shimmer items
        (index) => const Padding(
          padding: EdgeInsets.only(bottom: AppConstants.spacingL),
          child: HotelCardShimmer(),
        ),
      ),
    );
  }
}
