import 'package:flutter/material.dart';
import '../../data/models/ride_model.dart';
import '../../main.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    final getAllRidesUseCase = context
        .findAncestorWidgetOfExactType<MyApp>()
        ?.getAllRidesUseCase;
    final rideRepository = context
        .findAncestorWidgetOfExactType<MyApp>()
        ?.rideRepository;

    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              FutureBuilder<int>(
                future:
                    rideRepository?.getActiveRidesCount() ?? Future.value(0),
                builder: (context, snapshot) {
                  final activeRides = snapshot.data ?? 0;

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Overview',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          _buildStatCard(
                            'Active Rides',
                            activeRides.toString(),
                            Icons.directions_car,
                            Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              Text(
                'All Rides',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              StreamBuilder<List<RideModel>>(
                stream: getAllRidesUseCase?.call(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final rides = snapshot.data ?? [];
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: rides.length,
                    itemBuilder: (context, index) {
                      final ride = rides[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ExpansionTile(
                          title: Text('${ride.from} → ${ride.to}'),
                          subtitle: Text('Driver: ${ride.driver}'),
                          trailing: Chip(
                            label: Text(ride.status),
                            backgroundColor: ride.status == 'Active'
                                ? Colors.green
                                : Colors.grey,
                            labelStyle: const TextStyle(color: Colors.white),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Cab Number: ${ride.cabNumber}'),
                                  Text(
                                    'Date: ${ride.date.toString().split('.')[0]}',
                                  ),
                                  if (ride.companion.isNotEmpty)
                                    Text('Companion: ${ride.companion}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(title, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
