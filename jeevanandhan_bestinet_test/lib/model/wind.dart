class Wind {
  final double speed;
  /*final int deg;
  final double gust;*/

  Wind({required this.speed/*, required this.deg, required this.gust*/});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(speed: json['speed'] is int ? (json['speed'] as int).toDouble() : json['speed']
      /*, deg: json['deg'], gust: json['gust']*/);
  }
}
