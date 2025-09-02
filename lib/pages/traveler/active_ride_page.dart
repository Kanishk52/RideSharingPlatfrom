import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../../data/models/ride_model.dart';
import '../../main.dart';

class ActiveRidePage extends StatefulWidget {
  const ActiveRidePage({super.key});

  @override
  State<ActiveRidePage> createState() => _ActiveRidePageState();
}

class _ActiveRidePageState extends State<ActiveRidePage> {
  void _shareRideCode(BuildContext context, String rideId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Share Ride'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Share this code with your companion:'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      rideId,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: rideId));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Ride code copied!')),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

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
    // Debug log

    return Scaffold(
      appBar: AppBar(title: const Text('Active Ride')),
      body: FutureBuilder<RideModel?>(
        future: getActiveRideUseCase(userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // Debug log
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final ride = snapshot.data;
          // print('Active ride data: $ride'); // Debug log

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
                          title: Text(
                            ride.driverName,
                          ), // Changed from ride.driver
                          subtitle: Text(ride.cabNumber),
                          trailing: const Chip(
                            label: Text('Active'),
                            backgroundColor: Colors.green,
                            labelStyle: TextStyle(color: Colors.white),
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
              FloatingActionButton.extended(
                onPressed: () => _shareRideCode(context, ride.id),
                icon: const Icon(Icons.share),
                label: const Text('Share Ride'),
              ),
            ],
          );
        },
      ),
    );
  }
}
