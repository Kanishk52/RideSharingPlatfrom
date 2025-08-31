import 'package:flutter/material.dart';
import '../../constants/routes.dart';

class TravelerHome extends StatefulWidget {
  const TravelerHome({super.key});

  @override
  State<TravelerHome> createState() => _TravelerHomeState();
}

class _TravelerHomeState extends State<TravelerHome> {
  final List<Map<String, dynamic>> _dummyRides = [
    {
      'id': '1',
      'driver': 'John Doe',
      'from': 'Airport',
      'to': 'City Center',
      'status': 'Active',
      'cabNumber': 'KA-01-XX-1234',
    },
    {
      'id': '2',
      'driver': 'Jane Smith',
      'from': 'Mall',
      'to': 'Downtown',
      'status': 'Completed',
      'cabNumber': 'KA-01-YY-5678',
    },
  ];

  void _navigateToRideDetails(Map<String, dynamic> ride) {
    if (ride['status'] == 'Active') {
      Navigator.pushNamed(context, Routes.activeRide, arguments: ride);
    } else {
      Navigator.pushNamed(context, Routes.shareAudit, arguments: ride);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Rides'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.pushNamed(context, Routes.shareAudit),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Rides',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, Routes.shareAudit),
                            child: const Text('View All'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _dummyRides.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          final ride = _dummyRides[index];
                          return InkWell(
                            onTap: () => _navigateToRideDetails(ride),
                            child: ListTile(
                              title: Text(ride['driver'] ?? ''),
                              subtitle: Text('${ride['from']} → ${ride['to']}'),
                              trailing: Chip(
                                label: Text(
                                  ride['status'] ?? '',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: ride['status'] == 'Active'
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, Routes.createRide),
        label: const Text('New Ride'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
