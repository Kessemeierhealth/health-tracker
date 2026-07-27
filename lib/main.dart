import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'views/main_view.dart';

void main() {
  runApp(const HealthTrackerApp());
}

class HealthTrackerApp extends StatelessWidget {
  const HealthTrackerApp({super.key});

  @override 
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "HealthTracker",
      theme: AppTheme.light,
      home: const MainView(),
    );
  }
}