import 'package:flutter/material.dart';
import '../pages/traveler/traveler_home.dart';
import '../pages/companion/companion_home.dart';
import '../pages/admin/admin_dashboard.dart';

class MainNavigation extends StatefulWidget {
  final int initialIndex;

  const MainNavigation({super.key, this.initialIndex = 0});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late int _currentIndex;

  final List<Widget> _pages = [
    const TravelerHome(),
    const CompanionHome(),
    const AdminDashboard(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.directions_car),
            label: 'Traveler',
          ),
          NavigationDestination(icon: Icon(Icons.people), label: 'Companion'),
          NavigationDestination(
            icon: Icon(Icons.admin_panel_settings),
            label: 'Admin',
          ),
        ],
      ),
    );
  }
}
