import 'package:flutter/material.dart';
import 'package:travaly_app/core/constants/app_constants.dart';

class EmptyHotelState extends StatelessWidget {
  const EmptyHotelState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
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
    );
  }
}
