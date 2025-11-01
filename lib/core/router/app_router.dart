import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travaly_app/feature/auth/presentation/pages/login_page.dart';
import 'package:travaly_app/feature/hotel/presentation/bloc/hotel_bloc.dart';
import 'package:travaly_app/feature/hotel/presentation/pages/search_result_page.dart';
import 'package:travaly_app/feature/splash/presentation/screens/splash_screen.dart';

import 'package:travaly_app/feature/hotel/presentation/pages/home_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      pageBuilder: (context, state) =>
          const MaterialPage(child: SplashScreen()),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      pageBuilder: (context, state) => const MaterialPage(
        child: LoginPage(),
      ),
    ),
    GoRoute(
      path: '/search',
      name: 'search',
      builder: (context, state) {
        final searchQuery = state.uri.queryParameters['q'] ?? '';
        return BlocProvider.value(
          value: context.read<HotelBloc>(),
          child: SearchResultsPage(searchQuery: searchQuery),
        );
      },
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      pageBuilder: (context, state) => const MaterialPage(child: HomePage()),
    ),
  ],
);
