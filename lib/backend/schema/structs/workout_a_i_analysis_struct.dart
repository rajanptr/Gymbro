// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class WorkoutAIAnalysisStruct extends BaseStruct {
  WorkoutAIAnalysisStruct({
    String? summary,
    String? volume,
    String? performance,
    List<String>? highlights,
    String? nextGoal,
  })  : _summary = summary,
        _volume = volume,
        _performance = performance,
        _highlights = highlights,
        _nextGoal = nextGoal;

  // "summary" field.
  String? _summary;
  String get summary => _summary ?? '';
  set summary(String? val) => _summary = val;

  bool hasSummary() => _summary != null;

  // "volume" field.
  String? _volume;
  String get volume => _volume ?? '';
  set volume(String? val) => _volume = val;

  bool hasVolume() => _volume != null;

  // "performance" field.
  String? _performance;
  String get performance => _performance ?? '';
  set performance(String? val) => _performance = val;

  bool hasPerformance() => _performance != null;

  // "highlights" field.
  List<String>? _highlights;
  List<String> get highlights => _highlights ?? const [];
  set highlights(List<String>? val) => _highlights = val;

  void updateHighlights(Function(List<String>) updateFn) {
    updateFn(_highlights ??= []);
  }

  bool hasHighlights() => _highlights != null;

  // "next_goal" field.
  String? _nextGoal;
  String get nextGoal => _nextGoal ?? '';
  set nextGoal(String? val) => _nextGoal = val;

  bool hasNextGoal() => _nextGoal != null;

  static WorkoutAIAnalysisStruct fromMap(Map<String, dynamic> data) =>
      WorkoutAIAnalysisStruct(
        summary: data['summary'] as String?,
        volume: data['volume'] as String?,
        performance: data['performance'] as String?,
        highlights: getDataList(data['highlights']),
        nextGoal: data['next_goal'] as String?,
      );

  static WorkoutAIAnalysisStruct? maybeFromMap(dynamic data) => data is Map
      ? WorkoutAIAnalysisStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'summary': _summary,
        'volume': _volume,
        'performance': _performance,
        'highlights': _highlights,
        'next_goal': _nextGoal,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'summary': serializeParam(
          _summary,
          ParamType.String,
        ),
        'volume': serializeParam(
          _volume,
          ParamType.String,
        ),
        'performance': serializeParam(
          _performance,
          ParamType.String,
        ),
        'highlights': serializeParam(
          _highlights,
          ParamType.String,
          isList: true,
        ),
        'next_goal': serializeParam(
          _nextGoal,
          ParamType.String,
        ),
      }.withoutNulls;

  static WorkoutAIAnalysisStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      WorkoutAIAnalysisStruct(
        summary: deserializeParam(
          data['summary'],
          ParamType.String,
          false,
        ),
        volume: deserializeParam(
          data['volume'],
          ParamType.String,
          false,
        ),
        performance: deserializeParam(
          data['performance'],
          ParamType.String,
          false,
        ),
        highlights: deserializeParam<String>(
          data['highlights'],
          ParamType.String,
          true,
        ),
        nextGoal: deserializeParam(
          data['next_goal'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'WorkoutAIAnalysisStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is WorkoutAIAnalysisStruct &&
        summary == other.summary &&
        volume == other.volume &&
        performance == other.performance &&
        listEquality.equals(highlights, other.highlights) &&
        nextGoal == other.nextGoal;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([summary, volume, performance, highlights, nextGoal]);
}

WorkoutAIAnalysisStruct createWorkoutAIAnalysisStruct({
  String? summary,
  String? volume,
  String? performance,
  String? nextGoal,
}) =>
    WorkoutAIAnalysisStruct(
      summary: summary,
      volume: volume,
      performance: performance,
      nextGoal: nextGoal,
    );
