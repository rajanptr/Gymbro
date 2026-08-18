import '../database.dart';

class ExerciseSetHistoryTable extends SupabaseTable<ExerciseSetHistoryRow> {
  @override
  String get tableName => 'exercise_set_history';

  @override
  ExerciseSetHistoryRow createRow(Map<String, dynamic> data) =>
      ExerciseSetHistoryRow(data);
}

class ExerciseSetHistoryRow extends SupabaseDataRow {
  ExerciseSetHistoryRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ExerciseSetHistoryTable();

  String? get setId => getField<String>('set_id');
  set setId(String? value) => setField<String>('set_id', value);

  String? get workoutExerciseId => getField<String>('workout_exercise_id');
  set workoutExerciseId(String? value) =>
      setField<String>('workout_exercise_id', value);

  String? get exerciseId => getField<String>('exercise_id');
  set exerciseId(String? value) => setField<String>('exercise_id', value);

  String? get workoutId => getField<String>('workout_id');
  set workoutId(String? value) => setField<String>('workout_id', value);

  double? get weight => getField<double>('weight');
  set weight(double? value) => setField<double>('weight', value);

  int? get reps => getField<int>('reps');
  set reps(int? value) => setField<int>('reps', value);

  bool? get completed => getField<bool>('completed');
  set completed(bool? value) => setField<bool>('completed', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
