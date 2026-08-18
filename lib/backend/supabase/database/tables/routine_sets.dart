import '../database.dart';

class RoutineSetsTable extends SupabaseTable<RoutineSetsRow> {
  @override
  String get tableName => 'routine_sets';

  @override
  RoutineSetsRow createRow(Map<String, dynamic> data) => RoutineSetsRow(data);
}

class RoutineSetsRow extends SupabaseDataRow {
  RoutineSetsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RoutineSetsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String get routineExerciseId => getField<String>('routine_exercise_id')!;
  set routineExerciseId(String value) =>
      setField<String>('routine_exercise_id', value);

  int? get setNumber => getField<int>('set_number');
  set setNumber(int? value) => setField<int>('set_number', value);

  int? get targetReps => getField<int>('target_reps');
  set targetReps(int? value) => setField<int>('target_reps', value);

  double? get targetWeight => getField<double>('target_weight');
  set targetWeight(double? value) => setField<double>('target_weight', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  int? get restSeconds => getField<int>('rest_seconds');
  set restSeconds(int? value) => setField<int>('rest_seconds', value);
}
