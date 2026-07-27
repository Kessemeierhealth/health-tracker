import 'package:flutter/material.dart';
import 'health_data.dart';
import 'dashboard_settings.dart';

class Profile {
  final String name;
  final Color color;

  final HealthData healthData;
  final DashboardSettings dashboardSettings;

  const Profile({
    required this.name,
    required this.color,
    required this.healthData,
    required this.dashboardSettings,
  });
}

final goetz = Profile(
  name: "Götz",
  color: Colors.green,
  healthData: HealthData(
    weight: 0,
    waistCircumference: 0,
    pulse: 0,
  ),
  dashboardSettings: DashboardSettings(),
);

final christin = Profile(
  name: "Christin",
  color: Colors.black,
  healthData: HealthData(
    weight: 0,
    waistCircumference: 0,
    pulse: 0,
  ),
  dashboardSettings: DashboardSettings(),
);