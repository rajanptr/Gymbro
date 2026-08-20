// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class WorkoutAIResponseStruct extends BaseStruct {
  WorkoutAIResponseStruct({
    bool? success,
    WorkoutAIAnalysisStruct? analysis,
  })  : _success = success,
        _analysis = analysis;

  // "success" field.
  bool? _success;
  bool get success => _success ?? false;
  set success(bool? val) => _success = val;

  bool hasSuccess() => _success != null;

  // "analysis" field.
  WorkoutAIAnalysisStruct? _analysis;
  WorkoutAIAnalysisStruct get analysis =>
      _analysis ?? WorkoutAIAnalysisStruct();
  set analysis(WorkoutAIAnalysisStruct? val) => _analysis = val;

  void updateAnalysis(Function(WorkoutAIAnalysisStruct) updateFn) {
    updateFn(_analysis ??= WorkoutAIAnalysisStruct());
  }

  bool hasAnalysis() => _analysis != null;

  static WorkoutAIResponseStruct fromMap(Map<String, dynamic> data) =>
      WorkoutAIResponseStruct(
        success: data['success'] as bool?,
        analysis: data['analysis'] is WorkoutAIAnalysisStruct
            ? data['analysis']
            : WorkoutAIAnalysisStruct.maybeFromMap(data['analysis']),
      );

  static WorkoutAIResponseStruct? maybeFromMap(dynamic data) => data is Map
      ? WorkoutAIResponseStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'success': _success,
        'analysis': _analysis?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'success': serializeParam(
          _success,
          ParamType.bool,
        ),
        'analysis': serializeParam(
          _analysis,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static WorkoutAIResponseStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      WorkoutAIResponseStruct(
        success: deserializeParam(
          data['success'],
          ParamType.bool,
          false,
        ),
        analysis: deserializeStructParam(
          data['analysis'],
          ParamType.DataStruct,
          false,
          structBuilder: WorkoutAIAnalysisStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'WorkoutAIResponseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is WorkoutAIResponseStruct &&
        success == other.success &&
        analysis == other.analysis;
  }

  @override
  int get hashCode => const ListEquality().hash([success, analysis]);
}

WorkoutAIResponseStruct createWorkoutAIResponseStruct({
  bool? success,
  WorkoutAIAnalysisStruct? analysis,
}) =>
    WorkoutAIResponseStruct(
      success: success,
      analysis: analysis ?? WorkoutAIAnalysisStruct(),
    );
