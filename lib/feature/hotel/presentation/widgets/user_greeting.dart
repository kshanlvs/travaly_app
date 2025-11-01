import 'package:flutter/material.dart';
import 'package:travaly_app/core/constants/app_constants.dart';

class UserGreeting extends StatelessWidget {
  final String userName;

  const UserGreeting({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppText.hello,
          style: TextStyle(
            color: AppColors.white.withOpacity(0.7),
            fontSize: AppConstants.fontSizeM,
          ),
        ),
        const SizedBox(height: AppConstants.spacingXS),
        Text(
          userName,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: AppConstants.fontSizeXL,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
