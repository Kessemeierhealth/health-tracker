import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Später: Isar-Datenbank & SharedPreferences hier vorinstallieren

  runApp(
    const ProviderScope(
      child: HealthTrackerApp(),
    ),
  );
}