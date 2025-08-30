import 'package:flutter/material.dart';
import '../../constants/routes.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Dashboard'),
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Active Rides'),
              Tab(text: 'Analytics'),
            ],
          ),
        ),
        body: TabBarView(
          children: [_buildRidesList(context), _buildAnalytics()],
        ),
      ),
    );
  }

  Widget _buildRidesList(BuildContext context) {
    // TODO: Fetch rides from Firestore
    final rides = [
      {
        'id': '1',
        'traveler': 'Sarah Wilson',
        'status': 'Active',
        'from': 'Airport',
        'to': 'Downtown',
      },
      {
        'id': '2',
        'traveler': 'Mike Johnson',
        'status': 'Completed',
        'from': 'Mall',
        'to': 'Residence',
      },
    ];

    return ListView.builder(
      itemCount: rides.length,
      itemBuilder: (context, index) {
        final ride = rides[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(ride['traveler']!),
            subtitle: Text('${ride['from']} → ${ride['to']}'),
            trailing: Chip(
              label: Text(ride['status']!),
              backgroundColor: ride['status'] == 'Active'
                  ? Colors.green[100]
                  : Colors.grey[300],
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.rideDetail,
                arguments: ride['id'],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildAnalytics() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Summary',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildStatCard(
            'Total Rides',
            '1,234',
            Icons.directions_car,
            Colors.blue,
          ),
          const SizedBox(height: 8),
          _buildStatCard('Active Users', '456', Icons.people, Colors.green),
          const SizedBox(height: 8),
          _buildStatCard('Average Rating', '4.8', Icons.star, Colors.amber),
        ],
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
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
