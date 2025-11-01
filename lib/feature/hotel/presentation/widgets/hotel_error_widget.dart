import 'package:flutter/material.dart';
import 'package:travaly_app/core/constants/app_constants.dart';

class HotelErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const HotelErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
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
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, size: AppConstants.iconSizeM),
              label: const Text(AppText.retry),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.infoColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}