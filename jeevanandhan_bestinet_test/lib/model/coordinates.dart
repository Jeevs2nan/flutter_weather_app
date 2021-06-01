class Coordinates {
  double lattitude;
  double longitude;

  Coordinates({required this.longitude, required this.lattitude});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(longitude: json['lat'], lattitude: json['lon']);
  }
}
