import 'package:flutter/material.dart';
import '../../constants/routes.dart';

class TravelerHome extends StatefulWidget {
  const TravelerHome({super.key});

  @override
  State<TravelerHome> createState() => _TravelerHomeState();
}

class _TravelerHomeState extends State<TravelerHome> {
  final List<Map<String, String>> _dummyRides = [
    {
      'driver': 'John Doe',
      'from': 'Airport',
      'to': 'City Center',
      'status': 'Active'
    },
    {
      'driver': 'Jane Smith',
      'from': 'Mall',
      'to': 'Residence',
      'status': 'Completed'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Rides'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: _dummyRides.length,
        itemBuilder: (context, index) {
          final ride = _dummyRides[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('Driver: ${ride['driver']}'),
              subtitle: Text('${ride['from']} → ${ride['to']}'),
              trailing: Chip(
                label: Text(ride['status']!),
                backgroundColor: ride['status'] == 'Active' 
                    ? Colors.green[100] 
                    : Colors.grey[300],
              ),
              onTap: () => Navigator.pushNamed(
                context,
                Routes.activeRide,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(
          context,
          Routes.createRide,
        ),
        label: const Text('Create Ride'),
        icon: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Audit',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 1:
              Navigator.pushNamed(context, Routes.createRide);
              break;
            case 2:
              Navigator.pushNamed(context, Routes.shareAudit);
              break;
          }
        },
      ),
    );
  }
}