import 'package:flutter/material.dart';

/// Zentrale Router-Konfiguration der Anwendung.
///
/// Während Sprint 2 wird der Router schrittweise erweitert.
/// Aktuell existiert lediglich eine temporäre Startseite.
class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => const PlaceholderHomePage(),
      settings: settings,
    );
  }
}

/// Temporäre Startseite.
///
/// Diese Seite wird später durch die echte Startseite gemäß
/// `Start_Page_SPEC.md` ersetzt.
class PlaceholderHomePage extends StatelessWidget {
  const PlaceholderHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Tracker'),
      ),
      body: const Center(
        child: Text(
          'Health Tracker\n\nSprint 2\nImplementierung gestartet',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}