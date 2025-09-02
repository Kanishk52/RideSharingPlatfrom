import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../constants/routes.dart';
import '../../data/models/ride_model.dart';
import '../../main.dart';

class TravelerHome extends StatelessWidget {
  const TravelerHome({super.key});

  @override
  Widget build(BuildContext context) {
    final getRidesForUserUseCase = context
        .findAncestorWidgetOfExactType<MyApp>()
        ?.getRidesForUserUseCase;

    // Get current user ID
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    // print('Current user ID: $userId'); // Debug log

    if (getRidesForUserUseCase == null) {
      return const Scaffold(
        body: Center(child: Text('Error: Ride service not initialized')),
      );
    }

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
                      StreamBuilder<List<RideModel>>(
                        stream: getRidesForUserUseCase.call(userId),
                        builder: (context, snapshot) {
                          // print(
                          //   'Stream state: ${snapshot.connectionState}',
                          // ); // Debug log
                          if (snapshot.hasError) {
                            // print(
                            //   'Stream error: ${snapshot.error}',
                            // ); // Debug log
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          final rides = snapshot.data ?? [];
                          if (rides.isEmpty) {
                            return const Center(
                              child: Text('No recent rides.'),
                            );
                          }

                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: rides.length,
                            separatorBuilder: (_, __) => const Divider(),
                            itemBuilder: (context, index) {
                              final ride = rides[index];
                              return InkWell(
                                onTap: () =>
                                    _navigateToRideDetails(ride, context),
                                child: ListTile(
                                  title: Text(ride.driverName),
                                  subtitle: Text('${ride.from} → ${ride.to}'),
                                  trailing: Chip(
                                    label: Text(
                                      ride.status,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: ride.status == 'Active'
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.grey,
                                  ),
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

  void _navigateToRideDetails(RideModel ride, BuildContext context) {
    if (ride.status == 'Active') {
      Navigator.pushNamed(context, Routes.activeRide, arguments: ride);
    } else {
      Navigator.pushNamed(context, Routes.shareAudit, arguments: ride);
    }
  }
}
