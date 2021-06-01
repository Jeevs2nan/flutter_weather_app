import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jeevanandhan_bestinet_test/api/services.dart';
import 'package:jeevanandhan_bestinet_test/model/data_list.dart';
import 'package:jeevanandhan_bestinet_test/model/weather_model.dart';
import 'package:jeevanandhan_bestinet_test/screens/no_internet_connection_screen.dart';
import 'package:jeevanandhan_bestinet_test/util/Constant.dart';
import 'package:jeevanandhan_bestinet_test/util/network_connection.dart';
import 'package:provider/provider.dart';

class WeatherDetailsWidget extends StatelessWidget {

  String selectedDate = "";

  WeatherDetailsWidget(String selectedDate) : this.selectedDate = selectedDate;

  List<DataList> _dataList = [];

  late WeatherDo weatherdo;


  void _formatListBasedOnDate() {
    _dataList = weatherdo.dataList
                  .where((i) => i.dateTxt.contains(selectedDate))
                  .toList();
  }

  /*late String _cityname;

  bool _isDdropDownVisible = false;

  WeatherDetailsWidget(String _cityname, bool _isDdropDownVisible) {
    this._cityname = _cityname;
    this._isDdropDownVisible = _isDdropDownVisible;
  }

  @override
  State<WeatherDetailsWidget> createState() => _WeatherDetailsWidgetState();
}

class _WeatherDetailsWidgetState extends State<WeatherDetailsWidget> {
  void _onDropDownArrowPressed() {}*/



  @override
  Widget build(BuildContext context) {
    final services = Provider.of<Services>(context);
    final networkListener = Provider.of<NetworkConnection>(context);
    weatherdo = services.getResponseJson();
    _formatListBasedOnDate();
    return Container(
      child:  services.isFetching
              ? CircularProgressIndicator()
              : weatherdo != null
                  ? Expanded(
                      child: Column(
                        children: [
//                          SizedBox(
//                            height: 30,
//                          ),
//                          Row(
//                            children: [
//                              SizedBox(
//                                width: 40,
//                              ),
//                              Text(
//                                widget._cityname,
//                                style: TextStyle(
//                                    color: Colors.brown,
//                                    fontSize: 15,
//                                    fontWeight: FontWeight.bold),
//                              ),
//                              SizedBox(
//                                width: 10,
//                              ),
//                              Visibility(
//                                visible: widget._isDdropDownVisible,
//                                child: IconButton(
//                                  icon: Icon(Icons.arrow_drop_down),
//                                  onPressed: _onDropDownArrowPressed,
//                                ),
//                              ),
//                              SizedBox(
//                                width: 10,
//                              ),
//                              new Spacer(),
//                              Icon(Icons.calendar_view_week),
//                            ],
//                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: Constant.IMAGE_THUMNAL_URL +
                                      _dataList
                                          .elementAt(0)
                                          .weatherList
                                          .elementAt(0)
                                          .icon +
                                      Constant.IMAGE_URL_END,
                                  //image: AssetImage('assets/images/clouds.png'),
                                  width: 80,
                                  height: 80,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  _dataList
                                      .elementAt(0)
                                      .weatherList
                                      .elementAt(0)
                                      .description,
                                  //Description
                                  style: TextStyle(
                                      color: Colors.brown, fontSize: 30),
                                ),

                                Text(
                                  _dataList
                                      .elementAt(0).main.temperature.toString(), //temp
                                  style: TextStyle(
                                      color: Colors.brown, fontSize: 50),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      'Wind',
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontSize: 10,
                                          fontStyle: FontStyle.normal),
                                    ),
                                    Text(
                                      _dataList
                                              .elementAt(0)
                                              .wind
                                              .speed
                                              .toString() +
                                          'm/s',
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      'Humidity',
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontSize: 10,
                                          fontStyle: FontStyle.normal),
                                    ),
                                    Text(
                                      _dataList
                                          .elementAt(0)
                                          .main
                                          .humidity
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                _dataList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, position) {
                                  return listItem(
                                      context,
                                      position,
                                      _dataList
                                          .elementAt(position));
                                }),
                          ),
                        ],
                      ),
                    )
                  : Text('Value null'),
    );
  }

  Widget listItem(BuildContext context, int index, DataList dataList) {
    print('Enters list item::');
    String _date = DateFormat.MMMd().format(DateTime.parse(dataList.dateTxt));
    String _time = DateFormat("h:MMa").format(DateTime.parse(dataList.dateTxt));
    print(index);
    return Container(
      padding: EdgeInsets.all(5.0),

      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Text('$_date'),
          ),
          Card(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                      0.3,
                      1
                    ],
                    colors: [
                      Colors.lightBlueAccent,
                      Colors.lightBlue,
                    ]),
              ),
//              decoration: BoxDecoration(
//                color: Colors.lightBlue,
//
//              ),
              child: Column(
                children: [
                  Text('$_time'),
                  SizedBox(
                    height: 10,
                  ),
                  CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: Constant.IMAGE_THUMNAL_URL +
                        dataList.weatherList.elementAt(0).icon +
                        Constant.IMAGE_URL_END,
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(dataList.main.temperature.toString())
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
