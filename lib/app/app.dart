import 'package:flutter/material.dart';

import 'router.dart';

/// Einstiegspunkt der Flutter-Anwendung.
///
/// Die eigentliche Navigation wird zentral über den [AppRouter]
/// konfiguriert.
class HealthTrackerApp extends StatelessWidget {
  const HealthTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Tracker',
      debugShowCheckedModeBanner: false,

      // Theme
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
      ),

      // Navigation
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}