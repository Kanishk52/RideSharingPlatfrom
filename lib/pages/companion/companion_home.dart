import 'package:flutter/material.dart';
import '../../constants/routes.dart';

class CompanionHome extends StatefulWidget {
  const CompanionHome({super.key});

  @override
  State<CompanionHome> createState() => _CompanionHomeState();
}

class _CompanionHomeState extends State<CompanionHome> {
  final _rideCodeController = TextEditingController();

  @override
  void dispose() {
    _rideCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Companion Home')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Paste Ride Code to Track Ride:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _rideCodeController,
              decoration: const InputDecoration(
                labelText: 'Ride Code',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final rideId = _rideCodeController.text.trim();
                if (rideId.isNotEmpty) {
                  Navigator.pushNamed(
                    context,
                    Routes.trackRide,
                    arguments: rideId,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a ride code')),
                  );
                }
              },
              child: const Text('Track Ride'),
            ),
          ],
        ),
      ),
    );
  }
}
