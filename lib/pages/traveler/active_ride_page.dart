import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ActiveRidePage extends StatelessWidget {
  const ActiveRidePage({super.key});

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  rideId,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: rideId));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ride code copied!')),
                    );
                  },
                ),
              ],
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
    final ride =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(title: const Text('Active Ride')),
      body: Column(
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
                      title: Text(ride?['driver'] ?? 'Driver Name'),
                      subtitle: Text(ride?['cabNumber'] ?? 'Cab Number'),
                      trailing: const Chip(
                        label: Text('Active'),
                        backgroundColor: Colors.green,
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
                          Text('From: ${ride?['from'] ?? 'Starting Point'}'),
                          Text('To: ${ride?['to'] ?? 'Destination'}'),
                          Text(
                            'Cab: ${ride?['cabNumber'] ?? 'Vehicle Number'}',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () =>
                        _shareRideCode(context, ride?['id'] ?? 'ABC123'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: const Text('Share Ride'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
