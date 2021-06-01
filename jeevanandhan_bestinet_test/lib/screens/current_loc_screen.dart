import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:jeevanandhan_bestinet_test/api/services.dart';
import 'package:jeevanandhan_bestinet_test/widget/header_widget.dart';
import 'package:jeevanandhan_bestinet_test/widget/weather_details_widget.dart';
import 'package:provider/provider.dart';

class CurrentLocation extends StatefulWidget {
  @override
  _CurrentLocationState createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  //final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  late Services appState;

  Position? _currentPosition;

//  String? _currentAddress;

  String _cityName = "Current Location";

  /*double? _longitude = 101.707;
  double? _lattitude = 3.177480;*/
  double? _longitude = 0.0;

  double? _lattitude = 0.0;

  List<String> _dates = [];
  int _currentIndex = 0;
  int _currentDateIndex = 0;

  String _selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    //_getCurrentLocation();
    _getAddressFromLatLng();
    _loadDateList();
  }

  void _loadDateList() {
    final _currentDate = DateTime.now();
    for (int i = 0; i < 5; i++) {
      final date = _currentDate.add(Duration(days: i));
      _dates.add(DateFormat('yyyy-MM-dd').format(date));
    }
  }

  //_getCurrentLocation() {
////    geolocator
////        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
////        .then((Position position) {
////      setState(() {
////        _currentPosition = position;
////      });
////
////      _getAddressFromLatLng();
//    }).catchError((e) {
//      print(e);
//    });
  //}

  _getAddressFromLatLng() async {
    try {
      // verify permissions
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();
        await Geolocator.openLocationSettings();
      }

      _currentPosition = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high,
              forceAndroidLocationManager: true)
          .catchError((err) => print(err));

      //final coordinates = Coordinates(position.latitude, position.longitude);

// this fetches multiple address, but you need to get the first address by doing the following two codes
//      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
//      var first = addresses.first;

      //if (_currentPosition != null) {
      _longitude = _currentPosition!.longitude;
      _lattitude = _currentPosition!.latitude;

      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = p.first;

      setState(() {
        _cityName = place.locality.toString();

        appState..setLatLng(_lattitude!, _longitude!);
        appState..fetchFiveDayForecastWithLatLng();

//          _currentAddress =
//              "${place.locality}, ${place.postalCode}, ${place.country}";
      });
      //}
    } catch (e) {
      print(e);
    }
  }

  void onDateChanged(String selectedDate, int currentDateIndex) {
    setState(() {
      this._selectedDate = selectedDate;
      this._currentDateIndex = currentDateIndex;
    });
  }

  int _currentCityIndex = 0;
  void onCityChanged(String selectedCity, int currentCityIndex) {

  }

  void _onCalendarClicked() {
    _selectRingtone();
  }

  @override
  Widget build(BuildContext context) {
    //return WeatherDetailsWidget(_cityName, false);
    appState = Provider.of<Services>(context);
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(children: [
        HeaderWidget(_cityName, false, onDateChanged, onCityChanged, _currentCityIndex,
            _currentDateIndex, _selectedDate),

//        SizedBox(
//          height: 30,
//        ),
//        Row(
//          children: [
//            SizedBox(
//              width: 40,
//            ),
//            Text(
//              _cityName,
//              style: TextStyle(
//                  color: Colors.brown,
//                  fontSize: 15,
//                  fontWeight: FontWeight.bold),
//            ),
//            SizedBox(
//              width: 10,
//            ),
//            new Spacer(),
//            IconButton(
//              icon: Icon(Icons.calendar_today),
//              onPressed: _onCalendarClicked,
//            ),
//          ],
//        ),
        WeatherDetailsWidget(_selectedDate),
//        FutureBuilder<WeatherDo>(
//          future:
//              services.fetchFiveDayForecastWithLatLng(_lattitude!, _longitude!),
//          builder: (context, snapshot) {
//            if (snapshot.hasData) {
//              print(_longitude);
//              print(_lattitude);
//              print('size 777:' + snapshot.data!.dataList.length.toString());
//
//              List<DataList> _datalist = snapshot.data!.dataList
//                  .where((i) => i.dateTxt.contains('2021-05-31'))
//                  .toList();
//              /*return Center(
//            child: WeatherDetailsWidget(datalist: _datalist)
//            );*/
//
//              return Column(children: [
//                SizedBox(
//                  height: 10,
//                ),
//                Expanded(
//                  child: Column(
//                    children: [
//                      Image(
//                          image: AssetImage('assets/images/clouds.png'),
//                        width: 80,
//                        height: 80,
//                      ),
//                      SizedBox(
//                        height: 5,
//                      ),
//                      Text(
//                        'desc',
//                        //Description
//                        style: TextStyle(color: Colors.brown, fontSize: 30),
//                      ),
//                      SizedBox(
//                        height: 5,
//                      ),
//                      Text(
//                        '31', //temp
//                        style: TextStyle(color: Colors.brown, fontSize: 50),
//                      ),
//                    ],
//                  ),
//                ),
//              ]);
//            } else {
//              return Text("${snapshot.error}");
//            }
//          },
//        ),
      ]),
    );
  }

  void _okButtonCLicked() {
    setState(() {
      _selectedDate = _dates[_currentIndex];
    });
    Navigator.pop(context, _selectedDate);
  }

  void _selectRingtone() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState2) {
              return AlertDialog(
                title: Text('Phone Ringtone'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('CANCEL'),
                  ),
                  TextButton(
                    onPressed: _okButtonCLicked,
                    child: Text('OK'),
                  ),
                ],
                content: Container(
                  width: double.minPositive,
                  height: 300,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _dates.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RadioListTile(
                        value: index,
                        groupValue: _currentIndex,
                        title: Text(_dates[index]),
                        onChanged: (val) {
                          setState2(() {
                            _currentIndex = (val is int) ? val : 0;
                          });
                        },
                      );
                    },
                  ),
                ),
              );
            },
          );
        });
  }
}
