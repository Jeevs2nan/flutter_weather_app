import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jeevanandhan_bestinet_test/api/services.dart';
import 'package:jeevanandhan_bestinet_test/util/cities_data.dart';
import 'package:jeevanandhan_bestinet_test/widget/header_widget.dart';
import 'package:jeevanandhan_bestinet_test/widget/weather_details_widget.dart';
import 'package:provider/provider.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String _selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String _selectedCity = Cities.CITY_LIST.elementAt(0);
  late Services appState;

  int _currentCityIndex = 0;
  int _currentDateIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void onDateChanged(String selectedDate, int currentDateIndex) {
    setState(() {
      this._selectedDate = selectedDate;
      this._currentDateIndex = currentDateIndex;
    });
  }

  void onCityChanged(String selectedCity, int currentCityIndex) {
    setState(() {
      this._selectedCity = selectedCity;
      this._currentCityIndex = currentCityIndex;
    });

    /*if (!_selectedCity.isEmpty) {
      _selectedCity = Cities.CITY_LIST.elementAt(0);
      _currentCityIndex = 0;
    }*/
    appState..setCity(_selectedCity);
    appState..fetchFiveDayForecastWithCity();
  }

  @override
  Widget build(BuildContext context) {
    appState = Provider.of<Services>(context);

    return Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: Column(children: [
          HeaderWidget(
               _selectedCity,
               true,
               onDateChanged,
              onCityChanged,
              _currentCityIndex,
              _currentDateIndex,
              _selectedDate),
          WeatherDetailsWidget(_selectedDate),
        ]));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    appState.dispose();
  }
}
