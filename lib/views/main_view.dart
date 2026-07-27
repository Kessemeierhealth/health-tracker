import 'package:flutter/material.dart';
import '../models/profile.dart';

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
            itemBuilder: (context) => const [
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
      body: Center(
        child: Text(
          "Willkommen ${activeProfile.name}",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(
                color: activeProfile.color,
              ),
        ),
      ),
    );
  }
}