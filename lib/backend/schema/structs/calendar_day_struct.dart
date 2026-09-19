// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CalendarDayStruct extends BaseStruct {
  CalendarDayStruct({
    int? dayNumber,
    bool? isCurrentMonth,
    bool? isToday,
    DateTime? date,
    String? status,
  })  : _dayNumber = dayNumber,
        _isCurrentMonth = isCurrentMonth,
        _isToday = isToday,
        _date = date,
        _status = status;

  // "dayNumber" field.
  int? _dayNumber;
  int get dayNumber => _dayNumber ?? 0;
  set dayNumber(int? val) => _dayNumber = val;

  void incrementDayNumber(int amount) => dayNumber = dayNumber + amount;

  bool hasDayNumber() => _dayNumber != null;

  // "isCurrentMonth" field.
  bool? _isCurrentMonth;
  bool get isCurrentMonth => _isCurrentMonth ?? false;
  set isCurrentMonth(bool? val) => _isCurrentMonth = val;

  bool hasIsCurrentMonth() => _isCurrentMonth != null;

  // "isToday" field.
  bool? _isToday;
  bool get isToday => _isToday ?? false;
  set isToday(bool? val) => _isToday = val;

  bool hasIsToday() => _isToday != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDate() => _date != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  static CalendarDayStruct fromMap(Map<String, dynamic> data) =>
      CalendarDayStruct(
        dayNumber: castToType<int>(data['dayNumber']),
        isCurrentMonth: data['isCurrentMonth'] as bool?,
        isToday: data['isToday'] as bool?,
        date: data['date'] as DateTime?,
        status: data['status'] as String?,
      );

  static CalendarDayStruct? maybeFromMap(dynamic data) => data is Map
      ? CalendarDayStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'dayNumber': _dayNumber,
        'isCurrentMonth': _isCurrentMonth,
        'isToday': _isToday,
        'date': _date,
        'status': _status,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'dayNumber': serializeParam(
          _dayNumber,
          ParamType.int,
        ),
        'isCurrentMonth': serializeParam(
          _isCurrentMonth,
          ParamType.bool,
        ),
        'isToday': serializeParam(
          _isToday,
          ParamType.bool,
        ),
        'date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
      }.withoutNulls;

  static CalendarDayStruct fromSerializableMap(Map<String, dynamic> data) =>
      CalendarDayStruct(
        dayNumber: deserializeParam(
          data['dayNumber'],
          ParamType.int,
          false,
        ),
        isCurrentMonth: deserializeParam(
          data['isCurrentMonth'],
          ParamType.bool,
          false,
        ),
        isToday: deserializeParam(
          data['isToday'],
          ParamType.bool,
          false,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CalendarDayStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is CalendarDayStruct &&
        dayNumber == other.dayNumber &&
        isCurrentMonth == other.isCurrentMonth &&
        isToday == other.isToday &&
        date == other.date &&
        status == other.status;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([dayNumber, isCurrentMonth, isToday, date, status]);
}

CalendarDayStruct createCalendarDayStruct({
  int? dayNumber,
  bool? isCurrentMonth,
  bool? isToday,
  DateTime? date,
  String? status,
}) =>
    CalendarDayStruct(
      dayNumber: dayNumber,
      isCurrentMonth: isCurrentMonth,
      isToday: isToday,
      date: date,
      status: status,
    );
