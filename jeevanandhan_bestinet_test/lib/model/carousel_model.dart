import 'package:jeevanandhan_bestinet_test/model/sys.dart';
import 'package:jeevanandhan_bestinet_test/model/weather_list.dart';
import 'package:jeevanandhan_bestinet_test/model/wind.dart';

import 'cloud.dart';
import 'main_obj.dart';

class CarouselDo {
  late final int cod;

  late final String name;

  late final Main main;

  late final int dateUnix;

  late final List<WeatherList> weatherList;

  late final Cloud cloud;

  late final Wind wind;

  late final Sys sys;

  CarouselDo(
      {required this.cod,
      required this.name,
      required this.main,
      required this.weatherList,
      required this.cloud,
      required this.wind,
      required this.sys,
      required this.dateUnix});

  factory CarouselDo.fromJson(Map<String, dynamic> json) {
    var list = json['weather'] as List;
    return CarouselDo(
        cod: json['dt'],
        name: json['name'],
        main: Main.fromJson(json['main']),
        weatherList: list.map((e) => WeatherList.fromJson(e)).toList(),
        cloud: Cloud.fromJson(json['clouds']),
        wind: Wind.fromJson(json['wind']),
        sys: Sys.fromJson(json['sys']),
        dateUnix: json['dt']);
  }
}
