import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:travaly_app/app.dart';
import 'package:travaly_app/core/dependency_injection/service_locator.dart';
import 'package:travaly_app/core/network/network_client.dart';
import 'package:travaly_app/feature/hotel/data/repositories/hotel_repositories.dart';
import 'package:travaly_app/feature/hotel/data/repositories/hotel_repository_impl.dart';
import 'package:travaly_app/feature/hotel/di/hotel_service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp();
  
  setupDependencies();

  sl.registerLazySingleton<HotelRepository>(() => HotelRepositoryImpl(
    dio: sl<NetworkClient>(), // Use global sl, not slHotel
  ));
  runApp(const HotelBookingApp());
}
