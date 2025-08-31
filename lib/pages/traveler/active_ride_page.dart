import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/models/ride_model.dart';
import '../../main.dart';

class ActiveRidePage extends StatefulWidget {
  const ActiveRidePage({super.key});

  @override
  State<ActiveRidePage> createState() => _ActiveRidePageState();
}

class _ActiveRidePageState extends State<ActiveRidePage> {
  @override
  Widget build(BuildContext context) {
    final getActiveRideUseCase = context
        .findAncestorWidgetOfExactType<MyApp>()
        ?.getActiveRideUseCase;

    if (getActiveRideUseCase == null) {
      return const Scaffold(
        body: Center(child: Text('Error: Ride service not initialized')),
      );
    }

    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    print('Fetching active ride for user: $userId'); // Debug log

    return Scaffold(
      appBar: AppBar(title: const Text('Active Ride')),
      body: FutureBuilder<RideModel?>(
        future: getActiveRideUseCase(userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Error loading active ride: ${snapshot.error}'); // Debug log
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final ride = snapshot.data;
          print('Active ride data: $ride'); // Debug log

          if (ride == null) {
            return const Center(child: Text('No active ride found'));
          }

          return Column(
            children: [
              Container(
                height: 300,
                color: Colors.grey[200],
                child: const Center(child: Text('Map Preview')),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        child: ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(ride.driver),
                          subtitle: Text(ride.cabNumber),
                          trailing: Chip(
                            label: const Text('Active'),
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            labelStyle: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Trip Details',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Text('From: ${ride.from}'),
                              Text('To: ${ride.to}'),
                              Text('Cab: ${ride.cabNumber}'),
                              Text(
                                'Date: ${ride.date.toString().split('.')[0]}',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
