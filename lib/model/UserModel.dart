class User {
  String name,
      email,
      phone_number,
      nic,
      role,
      profile_image_url,
      vehicle_number,
      vehicle_type;
  int id;

  User({
    required this.name,
    required this.email,
    required this.phone_number,
    required this.nic,
    required this.role,
    required this.profile_image_url,
    required this.vehicle_number,
    required this.vehicle_type,
    required this.id,
  });
}

class Locations {
  int id, user_id;
  String name, location;
  double latitude, longitude;

  Locations({
    required this.name,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.id,
    required this.user_id,
  });
}

class Drivers {
  String name,
      email,
      email_verified_at,
      phone_number,
      nic,
      role,
      status,
      profile_image_url,
      vehicle_type;

  int id;
  Drivers({
    required this.name,
    required this.email,
    required this.email_verified_at,
    required this.phone_number,
    required this.nic,
    required this.role,
    required this.status,
    required this.profile_image_url,
    required this.vehicle_type,
    required this.id,
  });
}

class NearByDrivers {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final String nic;
  final String role;
  final String status;
  final String profileImageUrl;
  final String vehicleType;
  final int driverId;
  final double latitude;
  final double longitude;
  final String location;

  NearByDrivers({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.nic,
    required this.role,
    required this.status,
    required this.profileImageUrl,
    required this.vehicleType,
    required this.driverId,
    required this.latitude,
    required this.longitude,
    required this.location,
  });

  factory NearByDrivers.fromJson(Map<String, dynamic> json) {
    return NearByDrivers(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      phoneNumber: json["phone_number"] ?? "",
      nic: json["nic"] ?? "",
      role: json["role"] ?? "",
      status: json["status"] ?? "",
      profileImageUrl: json["profile_image_url"] ?? "",
      vehicleType: json["vehicle_type"] ?? "",
      driverId: json["driver_location"]["user_id"] ?? "",
      latitude: json["driver_location"]["latitude"] ?? "",
      longitude: json["driver_location"]["longitude"] ?? "",
      location: json["driver_location"]["location"] ?? "",
    );
  }
}


class Reqestedcards {
  final int id;
  final int customerId;
  final int driverId;
  final String status;
  final double fromLatitude;
  final double fromLongitude;
  final double toLatitude;
  final double toLongitude;
  final double distanceKm;
  final String createdAt;
  final String updatedAt;
  final String fromLocation;
  final String toLocation;

  Reqestedcards({
    required this.id,
    required this.customerId,
    required this.driverId,
    required this.status,
    required this.fromLatitude,
    required this.fromLongitude,
    required this.toLatitude,
    required this.toLongitude,
    required this.distanceKm,
    required this.createdAt,
    required this.updatedAt,
    required this.fromLocation,
    required this.toLocation,
  });

  factory Reqestedcards.fromJson(Map<String, dynamic> json) {
    return Reqestedcards(
      id: json["id"] ?? 0,
      customerId: json["customer_id"] ?? 0,
      driverId: json["driver_id"] ?? 0,
      status: json["status"] ?? "",
      fromLatitude: json["from_latitude"] ?? 0.0,
      fromLongitude: json["from_longitude"] ?? 0.0,
      toLatitude: json["to_latitude"] ?? 0.0,
      toLongitude: json["to_longitude"] ?? 0.0,
      distanceKm: json["distance_km"] ?? 0.0,
      createdAt: json["created_at"] ?? "",
      updatedAt: json["updated_at"] ?? "",
      fromLocation: json["from_location"] ?? "",
      toLocation: json["to_location"] ?? "",
    );
  }
}
