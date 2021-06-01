class Main {
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int seaLevel;
  final int grndLevel;
  final int humidity;
  //final double tempKf;

  Main(
      {required this.temperature,
      required this.feelsLike,
      required this.tempMin,
      required this.tempMax,
      required this.pressure,
      required this.seaLevel,
      required this.grndLevel,
      required this.humidity,
      /*required this.tempKf*/});

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
        temperature: json['temp'] is int ? (json['temp'] as int).toDouble() : json['temp'],
        feelsLike: json['feels_like'] is int ? (json['feels_like'] as int).toDouble() : json['feels_like'],
        tempMin: json['temp_min'] is int ? (json['temp_min'] as int).toDouble() : json['temp_min'],
        tempMax: json['temp_max'] is int ? (json['temp_max'] as int).toDouble() : json['temp_max'],
        pressure: json['pressure'],
        seaLevel: json['sea_level'],
        grndLevel: json['grnd_level'],
        humidity: json['humidity']
        /*tempKf: json['temp_kf']*/);
  }
}
