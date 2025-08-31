import '../../data/models/ride_model.dart';
import '../repositories/ride_repository.dart';

class CreateRideUseCase {
  final RideRepository _rideRepository;

  CreateRideUseCase(this._rideRepository);

  // UseCase calls repository
  Future<void> call(RideModel ride) async {
    await _rideRepository.createRide(ride);
  }
}

class GetRidesForUserUseCase {
  final RideRepository _rideRepository;
  GetRidesForUserUseCase(this._rideRepository);

  Stream<List<RideModel>> call(String userId) {
    return _rideRepository.getRidesForUser(userId);
  }
}

class GetActiveRideUseCase {
  final RideRepository _rideRepository;
  GetActiveRideUseCase(this._rideRepository);

  Future<RideModel?> call(String userId) {
    return _rideRepository.getActiveRide(userId);
  }
}

class UpdateRideStatusUseCase {
  final RideRepository _rideRepository;
  UpdateRideStatusUseCase(this._rideRepository);

  Future<void> call(String rideId, String status) {
    return _rideRepository.updateRideStatus(rideId, status);
  }
}
