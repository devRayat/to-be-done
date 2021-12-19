part of utils;

extension PercentSize on double {
  double get height => Get.height * this / 100;
  double get width => Get.width * this / 100;
}

extension DateTimeFormat on DateTime {
  String format({bool short = false}) {
    final ampm = hour >= 12 ? 'pm' : 'am';
    final _hour = hour == 0 ? 12 : (hour >= 12 ? hour - 12 : hour);
    final _dayOfWeek = _parseDayOfWeek(short: short);
    final _month = _parseMonth(short: short);

    final formated = '$_hour:$minute $ampm, $_dayOfWeek, $day $_month, $year';

    return formated;
  }

  String _parseDayOfWeek({bool short = false}) {
    String _dayOfWeek;

    switch (weekday) {
      case DateTime.saturday:
        _dayOfWeek = 'Saturday';
        break;
      case DateTime.sunday:
        _dayOfWeek = 'Sunday';
        break;
      case DateTime.monday:
        _dayOfWeek = 'Monday';
        break;
      case DateTime.tuesday:
        _dayOfWeek = 'Tuesday';
        break;
      case DateTime.wednesday:
        _dayOfWeek = 'Wednesday';
        break;
      case DateTime.thursday:
        _dayOfWeek = 'Thursday';
        break;
      case DateTime.friday:
        _dayOfWeek = 'Friday';
        break;
      default:
        _dayOfWeek = 'Saturday';
    }
    if (short) {
      _dayOfWeek = _dayOfWeek.substring(0, 3);
    }
    return _dayOfWeek;
  }

  String _parseMonth({bool short = false}) {
    String _month;

    switch (month) {
      case DateTime.january:
        _month = 'January';
        break;
      case DateTime.february:
        _month = 'February';
        break;
      case DateTime.march:
        _month = 'March';
        break;
      case DateTime.april:
        _month = 'April';
        break;
      case DateTime.may:
        _month = 'May';
        break;
      case DateTime.june:
        _month = 'June';
        break;
      case DateTime.july:
        _month = 'July';
        break;
      case DateTime.august:
        _month = 'August';
        break;
      case DateTime.september:
        _month = 'September';
        break;
      case DateTime.october:
        _month = 'October';
        break;
      case DateTime.november:
        _month = 'November';
        break;
      case DateTime.december:
        _month = 'December';
        break;
      default:
        _month = 'January';
    }
    if (short) {
      _month = _month.substring(0, 3);
    }
    return _month;
  }
}
