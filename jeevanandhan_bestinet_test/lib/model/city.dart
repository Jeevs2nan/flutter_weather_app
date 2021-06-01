import 'dart:html';

class City {
  final String id;
  final String name;
  final String country;
  final String population;
  final String timezone;
  final String sunrise;
  final String sunset;
  final Coordinates coordinates;

  City(
      {required this.id,
      required this.name,
      required this.country,
      required this.population,
      required this.timezone,
      required this.sunrise,
      required this.sunset,
      required this.coordinates});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
        id: json['id'],
        name: json['name'],
        country: json['country'],
        population: json['population'],
        timezone: json['timezone'],
        sunrise: json['sunrise'],
        sunset: json['sunset'],
        coordinates: json['coord']);
  }
}
