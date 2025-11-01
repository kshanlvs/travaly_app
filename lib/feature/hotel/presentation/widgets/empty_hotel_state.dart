import 'package:flutter/material.dart';
import 'package:travaly_app/core/constants/app_constants.dart';

class EmptyHotelState extends StatelessWidget {
  const EmptyHotelState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingXXL),
        child: Text(
          AppText.noHotelsFound,
          style: const TextStyle(
            fontSize: AppConstants.fontSizeL,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}