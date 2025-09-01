import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repositories/ride_repository.dart';
import '../models/ride_model.dart';
import '../services/ride_service.dart';

class FirebaseRideRepository implements RideRepository {
  final RideService _rideService;
  final FirebaseFirestore _firestore;

  FirebaseRideRepository(this._rideService)
    : _firestore = FirebaseFirestore.instance;

  @override
  Future<void> createRide(RideModel ride) async {
    try {
      // Business rules/validation here
      if (!_isValidRide(ride)) {
        throw Exception('Invalid ride data');
      }

      // Call service for Firebase operation
      await _rideService.createRide(ride);
    } catch (e) {
      throw _handleRideException(e as Exception? ?? Exception(e.toString()));
    }
  }

  @override
  Stream<List<RideModel>> getRidesForUser(String userId) {
    return _firestore
        .collection('rides')
        .where('driver', isEqualTo: userId)
        .orderBy('date', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => RideModel.fromMap(doc.data()))
              .toList(),
        );
  }

  @override
  Future<RideModel?> getActiveRide(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('rides')
          .where('driver', isEqualTo: userId)
          .where('status', isEqualTo: 'Active')
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return RideModel.fromMap(querySnapshot.docs.first.data());
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get active ride: $e');
    }
  }

  @override
  Future<void> updateRideStatus(String rideId, String status) async {
    try {
      await _firestore.collection('rides').doc(rideId).update({
        'status': status,
      });
    } catch (e) {
      throw Exception('Failed to update ride status: $e');
    }
  }

  @override
  Stream<List<RideModel>> getAllRides() {
    return _firestore
        .collection('rides')
        .orderBy('date', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => RideModel.fromMap({...doc.data(), 'id': doc.id}))
              .toList(),
        );
  }

  @override
  Future<int> getActiveRidesCount() async {
    final snapshot = await _firestore
        .collection('rides')
        .where('status', isEqualTo: 'Active')
        .get();
    return snapshot.size;
  }

  bool _isValidRide(RideModel ride) {
    // Add your business rule validations here
    return true;
  }

  Exception _handleRideException(Exception e) {
    if (e is FirebaseException) {
      return Exception('Firebase error: ${e.message}');
    }
    return e;
  }
}
