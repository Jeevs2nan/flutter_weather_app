

import 'package:intl/intl.dart';

class Utilities {

  static List<String> _loadDateList() {
    List<String> _dates = [];
    final _currentDate = DateTime.now();
    for (int i = 0; i < 5; i++) {
      final date = _currentDate.add(Duration(days: i));
      _dates.add(DateFormat('yyyy-MM-dd').format(date));
    }

    return _dates;
  }
}