import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travaly_app/core/dependency_injection/service_locator.dart'; // Import global sl
import 'package:travaly_app/core/device/di/device_service_locator.dart';
import 'package:travaly_app/core/device/presentation/bloc/device_bloc.dart';
import 'package:travaly_app/core/router/app_router.dart';
import 'package:travaly_app/feature/auth/di/auth_service_locator.dart';
import 'package:travaly_app/feature/auth/domain/interfaces/auth_service.dart';
import 'package:travaly_app/feature/auth/domain/interfaces/user_storage_service.dart';
import 'package:travaly_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:travaly_app/feature/auth/presentation/bloc/user_cubit.dart';
import 'package:travaly_app/feature/device/domain/repositories/device_repository.dart';
import 'package:travaly_app/core/storage/shared_preference_storage.dart';
import 'package:travaly_app/core/device/device_info_service.dart';
import 'package:travaly_app/feature/hotel/data/repositories/hotel_repositories.dart';
import 'package:travaly_app/feature/hotel/data/repositories/hotel_search_repository.dart';
import 'package:travaly_app/feature/hotel/presentation/bloc/hotel_bloc.dart';
import 'package:travaly_app/feature/hotel/presentation/bloc/search/search_bloc.dart';
import 'package:travaly_app/feature/hotel/presentation/widgets/header_section.dart';

class HotelBookingApp extends StatelessWidget {
  const HotelBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // ✅ Auth BLoC
        BlocProvider(
          create: (context) => AuthBloc(slAuth<GoogleAuthService>()),
        ),

        // ✅ Device BLoC
        BlocProvider(
          create: (context) => DeviceBloc(
            slDevice<DeviceRegistrationService>(),
            slDevice<SharedPrefsStorage>(),
            slDevice<DeviceInfoService>(),
          ),
        ),

        // ✅ Hotel BLoC - Use GLOBAL service locator
        BlocProvider(
          create: (context) => HotelBloc(
            hotelRepository: sl<HotelRepository>(),
            hotelSearchRepository: sl<HotelSearchRepository>(), // Use global sl
          ),
        ),
        RepositoryProvider<HotelSearchRepository>(
          create: (context) => sl<HotelSearchRepository>(), // Use global sl
        ),

        BlocProvider(
          create: (context) => sl<SearchBloc>(),
        ),
        BlocProvider(
          create: (context) => UserCubit(sl<UserStorageService>())..loadUser(),
          child: const HeaderSection(),
        )
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
          return MultiBlocListener(
            listeners: [
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
              ),
            ],
            child: child!,
          );
        },
      ),
    );
  }
}
