import 'package:flutter/material.dart';
import '../../constants/routes.dart';

class ActiveRidePage extends StatelessWidget {
  const ActiveRidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Ride'),
      ),
      body: Column(
        children: [
          // Dummy map preview
          Container(
            height: 300,
            color: Colors.grey[200],
            child: const Center(
              child: Text('Map Preview'),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Card(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text('John Doe'),
                      subtitle: Text('Driver'),
                      trailing: Chip(
                        label: Text('Active'),
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Trip Details',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text('From: Airport Terminal 1'),
                          Text('To: City Center Hotel'),
                          Text('Cab: KA-01-XX-1234'),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Generate and share ride ID
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Share Ride'),
                          content: const Text('Ride ID: ABC123\nShare this ID with your companion'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
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