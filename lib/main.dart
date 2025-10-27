import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travaly_app/app.dart';
import 'package:travaly_app/core/dependency_injection/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  setupDependencies();
  runApp(const HotelBookingApp());
}
