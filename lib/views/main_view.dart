import 'package:flutter/material.dart';
import '../models/profile.dart';
import 'dashboard_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  Profile activeProfile = goetz;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HealthTracker"),

        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),

          PopupMenuButton<Profile>(
            icon: const Icon(Icons.person),

            onSelected: (profile) {
              setState(() {
                activeProfile = profile;
              });
            },

            itemBuilder: (context) => [
              PopupMenuItem(
                value: goetz,
                child: Text("🟢 Götz"),
              ),

              PopupMenuItem(
                value: christin,
                child: Text("⚫ Christin"),
              ),
            ],
          ),
        ],
      ),

      body: DashboardView(
        profile: activeProfile,
      ),
    );
  }
}