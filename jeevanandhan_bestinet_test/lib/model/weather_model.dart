import 'package:jeevanandhan_bestinet_test/model/data_list.dart';

class WeatherDo {
  final String cod;
  final int message;
  final int cnt;

  final List<DataList> dataList;

  WeatherDo(
      {required this.cod,
      required this.message,
      required this.cnt,
      required this.dataList});

  factory WeatherDo.fromJson(Map<String, dynamic> json) {
    var list = json['list'] as List;
    return WeatherDo(
        cod: json['cod'],
        message: json['message'] ?? "",
        cnt: json['cnt'] ?? 0,
        dataList: list.map((e) => DataList.fomJson(e)).toList());
  }


}
