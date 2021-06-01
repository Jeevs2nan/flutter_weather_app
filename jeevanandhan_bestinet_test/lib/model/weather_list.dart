class WeatherList {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherList(
      {required this.id,
      required this.main,
      required this.description,
      required this.icon});

  factory WeatherList.fromJson(Map<String, dynamic> json) {
    return WeatherList(
        id: json['id'],
        main: json['main'],
        description: json['description'],
        icon: json['icon']);
  }
}
