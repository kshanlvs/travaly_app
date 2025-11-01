import 'package:flutter/material.dart';
import 'package:travaly_app/core/constants/app_constants.dart';
import 'package:travaly_app/feature/hotel/presentation/widgets/user_greeting.dart';
import 'package:travaly_app/feature/hotel/presentation/widgets/logout_dialog.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
                  const UserGreeting(userName: 'Dr Hohn Deo'),
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
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const LogoutDialog(),
    );
  }
}
