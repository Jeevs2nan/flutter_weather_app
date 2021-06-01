import 'package:jeevanandhan_bestinet_test/model/sys.dart';
import 'package:jeevanandhan_bestinet_test/model/weather_list.dart';
import 'package:jeevanandhan_bestinet_test/model/wind.dart';

import 'cloud.dart';
import 'main_obj.dart';

class DataList {
  late final int dateUnix;

  late final String dateTxt;

  late final int visibility;

  /*late final double pop;*/

  late final Main main;

  late final List<WeatherList> weatherList;

  late final Cloud cloud;

  late final Wind wind;

  late final Sys sys;

  DataList(
      {required this.dateUnix,
      required this.dateTxt,
      required this.visibility,
      /*required this.pop,*/
      required this.main,
      required this.weatherList,
      required this.cloud,
      required this.wind,
      required this.sys});

  factory DataList.fomJson(Map<String, dynamic> json) {
    var list = json['weather'] as List;
    return DataList(
        dateUnix: json['dt'],
        dateTxt: json['dt_txt'],
        visibility: json['visibility'],
        /*pop: json['pop'],*/
        main: Main.fromJson(json['main']),
        weatherList: list.map((e) => WeatherList.fromJson(e)).toList(),
        cloud: Cloud.fromJson(json['clouds']),
        wind: Wind.fromJson(json['wind']),
        sys: Sys.fromJson(json['sys']));
  }

  List<WeatherList> get getWeatherList => weatherList;

}
