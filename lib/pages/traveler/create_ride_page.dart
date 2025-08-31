import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../constants/routes.dart';
import '../../data/models/ride_model.dart';
import '../../domain/usecases/ride_usecases.dart';
import '../../main.dart';

class CreateRidePage extends StatefulWidget {
  const CreateRidePage({super.key});

  @override
  State<CreateRidePage> createState() => _CreateRidePageState();
}

class _CreateRidePageState extends State<CreateRidePage> {
  final _formKey = GlobalKey<FormState>();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _driverController = TextEditingController();
  final _companionController = TextEditingController();
  final _cabNumberController = TextEditingController();
  bool _isLoading = false;

  late final CreateRideUseCase _createRideUseCase;

  @override
  void initState() {
    super.initState();
    final useCase = context
        .findAncestorWidgetOfExactType<MyApp>()
        ?.createRideUseCase;
    if (useCase == null) {
      // Handle the error more gracefully
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('CreateRideUseCase not found')),
        );
        Navigator.pop(context);
      });
    }
    _createRideUseCase = useCase!;
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    _driverController.dispose();
    _companionController.dispose();
    _cabNumberController.dispose();
    super.dispose();
  }

  void _createRide() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId == null) {
          throw Exception('User not authenticated');
        }

        final ride = RideModel(
          id: const Uuid().v4(),
          from: _fromController.text,
          to: _toController.text,
          driver: userId, // Use actual user ID instead of text input
          companion: _companionController.text,
          cabNumber: _cabNumberController.text,
          status: 'Active',
          date: DateTime.now(),
        );

        await _createRideUseCase(ride);
        print('Ride created successfully'); // Debug log

        if (mounted) {
          Navigator.pushReplacementNamed(context, Routes.activeRide);
        }
      } catch (e) {
        print('Error creating ride: $e'); // Debug log
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create New Ride')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _driverController,
              decoration: const InputDecoration(
                labelText: 'Driver Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter driver name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _cabNumberController,
              decoration: const InputDecoration(
                labelText: 'Cab Number',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter cab number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _fromController,
              decoration: const InputDecoration(
                labelText: 'Pickup Location',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter pickup location';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _toController,
              decoration: const InputDecoration(
                labelText: 'Drop Location',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter drop location';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _createRide,
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Start Ride'),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
