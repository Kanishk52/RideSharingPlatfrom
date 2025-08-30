import 'package:flutter/material.dart';

class ShareAuditPage extends StatelessWidget {
  const ShareAuditPage({super.key});

  final List<Map<String, String>> _pastRides = const [
    {
      'date': '2025-08-29',
      'driver': 'John Doe',
      'from': 'Airport',
      'to': 'City Center',
      'companion': 'Alice Smith'
    },
    {
      'date': '2025-08-28',
      'driver': 'Jane Smith',
      'from': 'Mall',
      'to': 'Residence',
      'companion': 'Bob Johnson'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride History'),
      ),
      body: ListView.builder(
        itemCount: _pastRides.length,
        itemBuilder: (context, index) {
          final ride = _pastRides[index];
          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: ExpansionTile(
              title: Text('Ride on ${ride['date']}'),
              subtitle: Text('${ride['from']} → ${ride['to']}'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Driver: ${ride['driver']}'),
                      const SizedBox(height: 8),
                      Text('Companion: ${ride['companion']}'),
                      const SizedBox(height: 8),
                      const Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber),
                          Icon(Icons.star, color: Colors.amber),
                          Icon(Icons.star, color: Colors.amber),
                          Icon(Icons.star, color: Colors.amber),
                          Icon(Icons.star_half, color: Colors.amber),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}