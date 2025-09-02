import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/routes.dart';
import '../../data/models/ride_model.dart';

class TrackRidePage extends StatelessWidget {
  const TrackRidePage({super.key});

  Future<RideModel?> _fetchRide(String rideId) async {
    final doc = await FirebaseFirestore.instance
        .collection('rides')
        .doc(rideId)
        .get();
    if (doc.exists) {
      final data = doc.data()!;
      data['id'] = doc.id;
      return RideModel.fromMap(data);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final rideId = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(title: const Text('Track Ride')),
      body: rideId == null
          ? const Center(child: Text('No ride code provided'))
          : FutureBuilder<RideModel?>(
              future: _fetchRide(rideId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final ride = snapshot.data;
                if (ride == null) {
                  return const Center(child: Text('Ride not found'));
                }

                return Column(
                  children: [
                    Container(
                      height: 350,
                      color: Colors.grey[200],
                      child: Stack(
                        children: [
                          const Center(child: Text('Live Map View')),
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Started: ${ride.date.hour}:${ride.date.minute}',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Driver: ${ride.driverName}',
                            ), // Changed from ride.driver
                            Card(
                              child: ListTile(
                                leading: const CircleAvatar(
                                  child: Icon(Icons.person),
                                ),
                                title: Text(
                                  ride.driverName,
                                ), // Only show driver name
                                subtitle: Text('Cab: ${ride.cabNumber}'),
                                trailing: Chip(
                                  label: Text(ride.status),
                                  backgroundColor: ride.status == 'Active'
                                      ? Colors.green
                                      : Colors.grey,
                                  labelStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
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
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          color: Colors.red,
                                        ),
                                        const SizedBox(width: 8),
                                        Text('From: ${ride.from}'),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.flag,
                                          color: Colors.green,
                                        ),
                                        const SizedBox(width: 8),
                                        Text('To: ${ride.to}'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                            if (ride.status == 'Active')
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, Routes.feedback);
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(50),
                                ),
                                child: const Text(
                                  'End Tracking & Give Feedback',
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
