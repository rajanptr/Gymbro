import '../database.dart';

class ExerciseProgressTable extends SupabaseTable<ExerciseProgressRow> {
  @override
  String get tableName => 'exercise_progress';

  @override
  ExerciseProgressRow createRow(Map<String, dynamic> data) =>
      ExerciseProgressRow(data);
}

class ExerciseProgressRow extends SupabaseDataRow {
  ExerciseProgressRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ExerciseProgressTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String? get exerciseId => getField<String>('exercise_id');
  set exerciseId(String? value) => setField<String>('exercise_id', value);

  String? get exerciseName => getField<String>('exercise_name');
  set exerciseName(String? value) => setField<String>('exercise_name', value);

  double? get weight => getField<double>('weight');
  set weight(double? value) => setField<double>('weight', value);

  int? get reps => getField<int>('reps');
  set reps(int? value) => setField<int>('reps', value);

  bool? get completed => getField<bool>('completed');
  set completed(bool? value) => setField<bool>('completed', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
