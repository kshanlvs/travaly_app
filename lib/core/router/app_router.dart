import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travaly_app/feature/auth/presentation/pages/login_page.dart';
import 'package:travaly_app/feature/splash/presentation/screens/splash_screen.dart';

import '../../feature/hotel/presentation/pages/home_page.dart';

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
      path: '/home',
      name: 'home',
      pageBuilder: (context, state) => const MaterialPage(
        // child: HomePage(),
        child: HomePage()
      ),
    ),
  ],
);
