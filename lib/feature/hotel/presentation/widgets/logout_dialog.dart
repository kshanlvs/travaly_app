import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travaly_app/core/constants/app_constants.dart';
import 'package:travaly_app/feature/auth/presentation/bloc/auth_bloc.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
    );
  }
}