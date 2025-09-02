import 'package:flutter/material.dart';

class RideDetailPage extends StatelessWidget {
  const RideDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ride Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ride Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow('Traveler', 'Sarah Wilson'),
                    _buildInfoRow('Driver', 'John Doe'),
                    _buildInfoRow('From', 'Airport Terminal 1'),
                    _buildInfoRow('To', 'Downtown Hotel'),
                    _buildInfoRow('Status', 'Completed'),
                    _buildInfoRow('Duration', '45 minutes'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Audit Trail',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  ListTile(
                    leading: Icon(Icons.check_circle),
                    title: Text('Ride Completed'),
                    subtitle: Text('August 30, 2025 15:45'),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('Reached Destination'),
                    subtitle: Text('August 30, 2025 15:40'),
                  ),
                  ListTile(
                    leading: Icon(Icons.car_rental),
                    title: Text('Ride Started'),
                    subtitle: Text('August 30, 2025 15:00'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Feedback',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        Icon(Icons.star, color: Colors.amber),
                        Icon(Icons.star, color: Colors.amber),
                        Icon(Icons.star, color: Colors.amber),
                        Icon(Icons.star_half, color: Colors.amber),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Great experience! Driver was very professional and punctual.',
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Submitted by: Bob (Companion)',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
