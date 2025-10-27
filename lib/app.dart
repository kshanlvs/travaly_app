import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travaly_app/core/router/app_router.dart';
import 'package:travaly_app/feature/auth/di/auth_service_locator.dart';
import 'package:travaly_app/feature/auth/domain/interfaces/auth_service.dart';
import 'package:travaly_app/feature/auth/presentation/bloc/auth_bloc.dart';

class HotelBookingApp extends StatelessWidget {
  const HotelBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(slAuth<GoogleAuthService>()),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        title: 'Hotel Booking App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: child,
          );
        },
      ),
    );
  }
}
