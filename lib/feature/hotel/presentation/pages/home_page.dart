import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travaly_app/core/dependency_injection/service_locator.dart';
import 'package:travaly_app/core/constants/app_constants.dart';
import 'package:travaly_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:travaly_app/feature/hotel/data/repositories/hotel_repositories.dart';
import 'package:travaly_app/feature/hotel/data/repositories/hotel_search_repository.dart';
import 'package:travaly_app/feature/hotel/presentation/bloc/hotel_bloc.dart';
import 'package:travaly_app/feature/hotel/presentation/bloc/hotel_event.dart';
import 'package:travaly_app/feature/hotel/presentation/widgets/home_content.dart';

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
          create: (context) => HotelBloc(
              hotelRepository: sl<HotelRepository>(),
              hotelSearchRepository: sl<HotelSearchRepository>())
            ..add(
              const LoadPopularHotelsEvent(
                searchTypeInfo: {
                  'country': 'India',
                  'state': 'Jharkhand',
                  'city': 'Jamshedpur',
                },
              ),
            ),
          child: const HomeContent(),
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
