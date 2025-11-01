import 'package:flutter/material.dart';
import 'package:travaly_app/core/constants/app_constants.dart';

class CategoryButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const CategoryButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppConstants.spacingM),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? AppColors.primaryColor : AppColors.cardBackground,
          foregroundColor: isSelected ? AppColors.white : AppColors.textPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusM),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingXL,
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: AppConstants.fontSizeM),
        ),
      ),
    );
  }
}