import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jeevanandhan_bestinet_test/model/weather_model.dart';
import 'package:jeevanandhan_bestinet_test/util/Constant.dart';

class Services extends ChangeNotifier {
  Services();

  late double _latitude;

  late double _longitude;

  late String _city;

  String _jsonResponse = "";

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  Future<void> fetchFiveDayForecastWithLatLng() async {
    _isFetching = true;
    String url = Constant.BASE_URL +
        Constant.FORECAST_WITH_LAT +
        _latitude.toString() +
        Constant.LONG +
        _longitude.toString() +
        Constant.APP_ID +
        Constant.OPEN_WEATHER_API +
        Constant.CELCIUS_PARAMETER;
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      _jsonResponse = response.body;
      //return WeatherDo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
    _isFetching = false;
    notifyListeners();
  }

  Future<void> fetchFiveDayForecastWithCity() async {
    _isFetching = true;
    String url = Constant.BASE_URL +
        Constant.FORECAST_WITH_CITY +
        _city +
        Constant.APP_ID +
        Constant.OPEN_WEATHER_API +
        Constant.CELCIUS_PARAMETER;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      _jsonResponse = response.body;
      //return WeatherDo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
    _isFetching = false;
    notifyListeners();
  }

  void setLatLng(double _latitude, double _longitude) {
    this._latitude = _latitude;
    this._longitude = _longitude;
    notifyListeners();
  }

  void setCity(String _city) {
    this._city = _city;
    //notifyListeners();
  }

  dynamic getResponseJson() {
    if (_jsonResponse.isNotEmpty) {
      return WeatherDo.fromJson(json.decode(_jsonResponse));
    }
  }
}
