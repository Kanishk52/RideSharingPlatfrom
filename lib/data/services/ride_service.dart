import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ride_model.dart';

class RideService {
  final FirebaseFirestore _firestore;

  RideService([FirebaseFirestore? firestore])
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> createRide(RideModel ride) async {
    try {
      await _firestore.collection('rides').doc(ride.id).set(ride.toMap());
      print('Ride created successfully: ${ride.id}'); // Debug log
    } catch (e) {
      print('Error creating ride: $e'); // Debug log
      rethrow;
    }
  }

  Stream<List<RideModel>> getRidesForUser(String userId) {
    print('Fetching rides for user: $userId'); // Debug log
    return _firestore
        .collection('rides')
        .where('driver', isEqualTo: userId)
        .orderBy('date', descending: true)
        .orderBy('__name__', descending: true) // Add this to match index
        .snapshots()
        .map((snapshot) {
          print('Received ${snapshot.docs.length} rides'); // Debug log
          return snapshot.docs.map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            print('Processing ride: ${doc.id} with data: $data'); // Debug log
            return RideModel.fromMap(data);
          }).toList();
        });
  }

  Future<RideModel?> getActiveRide(String userId) async {
    print('Fetching active ride for user: $userId'); // Debug log
    try {
      final querySnapshot = await _firestore
          .collection('rides')
          .where('driver', isEqualTo: userId)
          .where('status', isEqualTo: 'Active')
          .orderBy('date', descending: true)
          .limit(1)
          .get();

      print('Query result size: ${querySnapshot.size}'); // Debug log

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        final data = doc.data();
        data['id'] = doc.id;
        print('Found active ride data: $data'); // Debug log
        return RideModel.fromMap(data);
      }
      return null;
    } catch (e) {
      print('Error in getActiveRide: $e'); // Debug log
      rethrow;
    }
  }
}
