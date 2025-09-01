import '../../data/models/ride_model.dart';

abstract class RideRepository {
  Future<void> createRide(RideModel ride);
  Stream<List<RideModel>> getRidesForUser(String userId);
  Future<RideModel?> getActiveRide(String userId);
  Future<void> updateRideStatus(String rideId, String status);
  Stream<List<RideModel>> getAllRides();
  Future<int> getActiveRidesCount();
}
