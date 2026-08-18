// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CalendarDayStruct extends BaseStruct {
  CalendarDayStruct({
    int? dayNumber,
    bool? isCurrentMonth,
    bool? isToday,
    bool? hasWorkout,
    bool? isRestDay,
    DateTime? date,
    bool? isEmpty,
  })  : _dayNumber = dayNumber,
        _isCurrentMonth = isCurrentMonth,
        _isToday = isToday,
        _hasWorkout = hasWorkout,
        _isRestDay = isRestDay,
        _date = date,
        _isEmpty = isEmpty;

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

  // "hasWorkout" field.
  bool? _hasWorkout;
  bool get hasWorkout => _hasWorkout ?? false;
  set hasWorkout(bool? val) => _hasWorkout = val;

  bool hasHasWorkout() => _hasWorkout != null;

  // "isRestDay" field.
  bool? _isRestDay;
  bool get isRestDay => _isRestDay ?? false;
  set isRestDay(bool? val) => _isRestDay = val;

  bool hasIsRestDay() => _isRestDay != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDate() => _date != null;

  // "isEmpty" field.
  bool? _isEmpty;
  bool get isEmpty => _isEmpty ?? false;
  set isEmpty(bool? val) => _isEmpty = val;

  bool hasIsEmpty() => _isEmpty != null;

  static CalendarDayStruct fromMap(Map<String, dynamic> data) =>
      CalendarDayStruct(
        dayNumber: castToType<int>(data['dayNumber']),
        isCurrentMonth: data['isCurrentMonth'] as bool?,
        isToday: data['isToday'] as bool?,
        hasWorkout: data['hasWorkout'] as bool?,
        isRestDay: data['isRestDay'] as bool?,
        date: data['date'] as DateTime?,
        isEmpty: data['isEmpty'] as bool?,
      );

  static CalendarDayStruct? maybeFromMap(dynamic data) => data is Map
      ? CalendarDayStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'dayNumber': _dayNumber,
        'isCurrentMonth': _isCurrentMonth,
        'isToday': _isToday,
        'hasWorkout': _hasWorkout,
        'isRestDay': _isRestDay,
        'date': _date,
        'isEmpty': _isEmpty,
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
        'hasWorkout': serializeParam(
          _hasWorkout,
          ParamType.bool,
        ),
        'isRestDay': serializeParam(
          _isRestDay,
          ParamType.bool,
        ),
        'date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
        'isEmpty': serializeParam(
          _isEmpty,
          ParamType.bool,
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
        hasWorkout: deserializeParam(
          data['hasWorkout'],
          ParamType.bool,
          false,
        ),
        isRestDay: deserializeParam(
          data['isRestDay'],
          ParamType.bool,
          false,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
        isEmpty: deserializeParam(
          data['isEmpty'],
          ParamType.bool,
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
        hasWorkout == other.hasWorkout &&
        isRestDay == other.isRestDay &&
        date == other.date &&
        isEmpty == other.isEmpty;
  }

  @override
  int get hashCode => const ListEquality().hash([
        dayNumber,
        isCurrentMonth,
        isToday,
        hasWorkout,
        isRestDay,
        date,
        isEmpty
      ]);
}

CalendarDayStruct createCalendarDayStruct({
  int? dayNumber,
  bool? isCurrentMonth,
  bool? isToday,
  bool? hasWorkout,
  bool? isRestDay,
  DateTime? date,
  bool? isEmpty,
}) =>
    CalendarDayStruct(
      dayNumber: dayNumber,
      isCurrentMonth: isCurrentMonth,
      isToday: isToday,
      hasWorkout: hasWorkout,
      isRestDay: isRestDay,
      date: date,
      isEmpty: isEmpty,
    );
