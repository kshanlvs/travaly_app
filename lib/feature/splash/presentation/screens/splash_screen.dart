import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travaly_app/core/device/presentation/bloc/device_bloc.dart';
import 'package:travaly_app/feature/auth/presentation/bloc/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    context.read<DeviceBloc>().add(CheckDeviceRegistrationEvent());
  }

  void _retryRegistration() {
    context.read<DeviceBloc>().add(RegisterDeviceEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DeviceBloc, DeviceState>(
          listener: (context, deviceState) {
            if (deviceState is DeviceRegisteredSuccess) {
              // ✅ Only check auth after device is ready
              context.read<AuthBloc>().add(CheckAuthStatusEvent());
            } else if (deviceState is DeviceNotRegistered) {
              context.read<DeviceBloc>().add(RegisterDeviceEvent());
            } else if (deviceState is DeviceRegistrationFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(deviceState.error)),
              );
            }
          },
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, authState) {
            if (authState is AuthSuccess) {
              context.go('/home');
            } else if (authState is AuthLoggedOut ||
                authState is AuthInitial ||
                authState is AuthFailure) {
              context.go('/login');
            }
          },
        ),
      ],
      child: const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
