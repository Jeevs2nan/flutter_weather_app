import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jeevanandhan_bestinet_test/util/cities_data.dart';

class HeaderWidget extends StatelessWidget {
  bool isDropDownIconVisible = false;
  String _selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  late Function onDateChanged;

  late Function onCityChanged;

  String selectedCity = "";

  List<String> _dates = [];
  int currentIndex = 0;
  int currentIndexCity = 0;
  late BuildContext _context;

  /*HeaderWidget(
      {required this.selectedCity,
      this.isDropDownIconVisible = false,
      required this.onDateChanged,
      this.onCityChanged,
      this.currentIndexCity = 0,
      required this.currentIndex}) : loadDateList();*/

  HeaderWidget(String selectedCity, bool isDropDownIconVisible,Function onDateChanged, Function onCityChanged,
      int currentIndexCity, int currentIndex, String selectedDate) {
    this.isDropDownIconVisible = isDropDownIconVisible;
    this.onDateChanged = onDateChanged;
    this.onCityChanged = onCityChanged;
    this.selectedCity = selectedCity;
    this.currentIndexCity = currentIndexCity;
    this.currentIndex = currentIndex;
    this._selectedDate = selectedDate;

    loadDateList();
    //_setDefaultCity();
  }

  void _setDefaultCity() {
    selectedCity = Cities.CITY_LIST.elementAt(0);
    onCityChanged(selectedCity, currentIndexCity);
  }

  void loadDateList() {
    final _currentDate = DateTime.now();
    for (int i = 0; i < 5; i++) {
      final date = _currentDate.add(Duration(days: i));
      _dates.add(DateFormat('yyyy-MM-dd').format(date));
    }

    onDateChanged(_selectedDate, currentIndex);
  }

  void _onDropDownArrowPressed() {
    _cityDialog();
  }

  void _onCalendarClicked() {
    _dateDialog();
  }

  /*@override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {*/
  @override
  Widget build(BuildContext context) {
    this._context = context;
    (!selectedCity.isEmpty) ? selectedCity : selectedCity=Cities.CITY_LIST.elementAt(0);
    /*_selectedCity = _cities.elementAt(0);
    _onCityChanged(_selectedCity);*/
    return Container(
      child: Column(children: [
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            SizedBox(
              width: 40,
            ),
            Text(
              selectedCity,
              style: TextStyle(
                  color: Colors.brown,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 10,
            ),
            Visibility(
              visible: isDropDownIconVisible,
              child: IconButton(
                icon: Icon(Icons.arrow_drop_down),
                onPressed: _onDropDownArrowPressed,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            new Spacer(),
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: _onCalendarClicked,
            ),
          ],
        ),
      ]),
    );
  }

  void _okButtonCLicked() {
    _selectedDate = _dates[currentIndex];
    onDateChanged(_selectedDate, currentIndex);
    Navigator.pop(_context, _selectedDate);
  }

  void _dateDialog() async {
    return showDialog(
        context: _context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState2) {
              return AlertDialog(
                title: Text('Select Date'),
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
                        groupValue: currentIndex,
                        title: Text(_dates[index]),
                        onChanged: (val) {
                          setState2(() {
                            currentIndex = (val is int) ? val : 0;
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

  void _cityOkBtnClicked() {
    selectedCity = Cities.CITY_LIST[currentIndexCity];
    onCityChanged(selectedCity, currentIndexCity);
    Navigator.pop(_context, selectedCity);
  }

  void _cityDialog() async {
    return showDialog(
        context: _context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState2) {
              return AlertDialog(
                title: Text('Select Date'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('CANCEL'),
                  ),
                  TextButton(
                    onPressed: _cityOkBtnClicked,
                    child: Text('OK'),
                  ),
                ],
                content: Container(
                  width: double.minPositive,
                  height: 300,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: Cities.CITY_LIST.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RadioListTile(
                        value: index,
                        groupValue: currentIndexCity,
                        title: Text(Cities.CITY_LIST[index]),
                        onChanged: (val) {
                          setState2(() {
                            currentIndexCity = (val is int) ? val : 0;
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
