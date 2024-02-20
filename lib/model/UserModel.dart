class User {
  String name,
      email,
      phone_number,
      nic,
      role,
      profile_image_url,
      vehicle_number,
      vehicle_type;

  User({
    required this.name,
    required this.email,
    required this.phone_number,
    required this.nic,
    required this.role,
    required this.profile_image_url,
    required this.vehicle_number,
    required this.vehicle_type,
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
