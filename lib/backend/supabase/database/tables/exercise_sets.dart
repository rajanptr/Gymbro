import '../database.dart';

class ExerciseSetsTable extends SupabaseTable<ExerciseSetsRow> {
  @override
  String get tableName => 'exercise_sets';

  @override
  ExerciseSetsRow createRow(Map<String, dynamic> data) => ExerciseSetsRow(data);
}

class ExerciseSetsRow extends SupabaseDataRow {
  ExerciseSetsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ExerciseSetsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String get workoutExerciseId => getField<String>('workout_exercise_id')!;
  set workoutExerciseId(String value) =>
      setField<String>('workout_exercise_id', value);

  int get setNumber => getField<int>('set_number')!;
  set setNumber(int value) => setField<int>('set_number', value);

  bool? get isWarmup => getField<bool>('is_warmup');
  set isWarmup(bool? value) => setField<bool>('is_warmup', value);

  double? get weight => getField<double>('weight');
  set weight(double? value) => setField<double>('weight', value);

  int? get reps => getField<int>('reps');
  set reps(int? value) => setField<int>('reps', value);

  double? get rpe => getField<double>('rpe');
  set rpe(double? value) => setField<double>('rpe', value);

  bool? get completed => getField<bool>('completed');
  set completed(bool? value) => setField<bool>('completed', value);

  String? get note => getField<String>('note');
  set note(String? value) => setField<String>('note', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get setType => getField<String>('set_type');
  set setType(String? value) => setField<String>('set_type', value);
}
