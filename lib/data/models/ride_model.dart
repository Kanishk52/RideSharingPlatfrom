class RideModel {
  final String id;
  final String from;
  final String to;
  final String driver; // This will store userId
  final String driverName; // This will store driver's name
  final String companion;
  final String cabNumber;
  final String status;
  final DateTime date;

  RideModel({
    required this.id,
    required this.from,
    required this.to,
    required this.driver,
    required this.driverName,
    required this.companion,
    required this.cabNumber,
    required this.status,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'from': from,
      'to': to,
      'driver': driver,
      'driverName': driverName,
      'companion': companion,
      'cabNumber': cabNumber,
      'status': status,
      'date': date.toIso8601String(),
    };
  }

  factory RideModel.fromMap(Map<String, dynamic> map) {
    return RideModel(
      id: map['id'] ?? '',
      from: map['from'] ?? '',
      to: map['to'] ?? '',
      driver: map['driver'] ?? '',
      driverName: map['driverName'] ?? '',
      companion: map['companion'] ?? '',
      cabNumber: map['cabNumber'] ?? '',
      status: map['status'] ?? '',
      date: DateTime.parse(map['date']),
    );
  }
}
