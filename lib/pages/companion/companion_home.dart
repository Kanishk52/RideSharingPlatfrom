import 'package:flutter/material.dart';
import '../../constants/routes.dart';

class CompanionHome extends StatelessWidget {
  const CompanionHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Ride'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ride Companion',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Track and monitor rides',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Track Ride'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, Routes.trackRide);
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text('Feedback'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, Routes.feedback);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter Ride Share ID',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Share ID',
                border: OutlineInputBorder(),
                hintText: 'Enter the ID shared by the traveler',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // TODO: Validate share ID and navigate to track page
                Navigator.pushNamed(context, Routes.trackRide);
              },
              child: const Text('Start Tracking'),
            ),
            const SizedBox(height: 32),
            const Center(
              child: Text('or'),
            ),
            const SizedBox(height: 32),
            OutlinedButton.icon(
              onPressed: () {
                // TODO: Implement deep link handling
              },
              icon: const Icon(Icons.link),
              label: const Text('Open Ride Link'),
            ),
          ],
        ),
      ),
    );
  }
}