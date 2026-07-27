import 'package:flutter/material.dart';
import '../models/profile.dart';
import '../widgets/health_card.dart';

class DashboardView extends StatelessWidget {
  final Profile profile;

  const DashboardView({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final data = profile.healthData;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "Willkommen ${profile.name}",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(
                  color: profile.color,
                  fontWeight: FontWeight.bold,
                ),
          ),

          const SizedBox(height: 20),

          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [

              HealthCard(
                title: "Gewicht",
                value: data.weight != null
                    ? "${data.weight} kg"
                    : "-- kg",
                icon: Icons.monitor_weight,
                color: profile.color,
              ),

              HealthCard(
                title: "Bauchumfang",
                value: data.waistCircumference != null
                    ? "${data.waistCircumference} cm"
                    : "-- cm",
                icon: Icons.straighten,
                color: profile.color,
              ),

              HealthCard(
                title: "Blutdruck",
                value: data.systolic != null
                    ? "${data.systolic}/${data.diastolic}"
                    : "--/--",
                icon: Icons.favorite,
                color: profile.color,
              ),

              HealthCard(
                title: "Puls",
                value: data.pulse != null
                    ? "${data.pulse}"
                    : "--",
                icon: Icons.monitor_heart,
                color: profile.color,
              ),

            ],
          ),
        ],
      ),
    );
  }
}