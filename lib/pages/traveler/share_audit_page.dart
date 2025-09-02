import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/models/ride_model.dart';
import '../../main.dart';

class ShareAuditPage extends StatefulWidget {
  const ShareAuditPage({super.key});

  @override
  State<ShareAuditPage> createState() => _ShareAuditPageState();
}

class _ShareAuditPageState extends State<ShareAuditPage> {
  @override
  Widget build(BuildContext context) {
    final getRidesForUserUseCase = context
        .findAncestorWidgetOfExactType<MyApp>()
        ?.getRidesForUserUseCase;

    if (getRidesForUserUseCase == null) {
      return const Scaffold(
        body: Center(child: Text('Error: Ride service not initialized')),
      );
    }

    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    // print('Fetching ride history for user: $userId'); // Debug log

    return Scaffold(
      appBar: AppBar(title: const Text('Ride History')),
      body: StreamBuilder<List<RideModel>>(
        stream: getRidesForUserUseCase(userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // print('Error loading ride history: ${snapshot.error}'); // Debug log
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final rides = snapshot.data ?? [];
          // print('Received ${rides.length} rides'); // Debug log

          if (rides.isEmpty) {
            return const Center(child: Text('No ride history available'));
          }

          return ListView.builder(
            itemCount: rides.length,
            itemBuilder: (context, index) {
              final ride = rides[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: ExpansionTile(
                  title: Text('Ride on ${ride.date.toString().split('.')[0]}'),
                  subtitle: Text('${ride.from} → ${ride.to}'),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Driver: ${ride.driverName}',
                          ), // Changed from ride.driver
                          const SizedBox(height: 8),
                          Text('Cab Number: ${ride.cabNumber}'),
                          const SizedBox(height: 8),
                          Text('Status: ${ride.status}'),
                          const SizedBox(height: 8),
                          const Row(
                            children: [
                              Icon(Icons.star_border, color: Colors.black),
                              Icon(Icons.star_border, color: Colors.black),
                              Icon(Icons.star_border, color: Colors.black),
                              Icon(Icons.star_border, color: Colors.black),
                              Icon(Icons.star_border, color: Colors.black),
                            ],
                          ),
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
    );
  }
}
