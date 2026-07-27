import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text('Dashboard')),
    const Center(child: Text('Erfassen')),
    const Center(child: Text('Ernährung')),
    const Center(child: Text('Verlauf')),
    const Center(child: Text('Analyse')),
    const Center(child: Text('Medikamente')),
    const Center(child: Text('Ziele')),
    const Center(child: Text('Profile')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HealthTracker'),
      ),

      body: _pages[_selectedIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle),
            label: 'Erfassen',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant),
            label: 'Ernährung',
          ),
          NavigationDestination(
            icon: Icon(Icons.show_chart),
            label: 'Verlauf',
          ),
          NavigationDestination(
            icon: Icon(Icons.psychology),
            label: 'Analyse',
          ),
          NavigationDestination(
            icon: Icon(Icons.medication),
            label: 'Medikamente',
          ),
          NavigationDestination(
            icon: Icon(Icons.flag),
            label: 'Ziele',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}