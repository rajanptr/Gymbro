import '../database.dart';

class WorkoutExercisesTable extends SupabaseTable<WorkoutExercisesRow> {
  @override
  String get tableName => 'workout_exercises';

  @override
  WorkoutExercisesRow createRow(Map<String, dynamic> data) =>
      WorkoutExercisesRow(data);
}

class WorkoutExercisesRow extends SupabaseDataRow {
  WorkoutExercisesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => WorkoutExercisesTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String get workoutId => getField<String>('workout_id')!;
  set workoutId(String value) => setField<String>('workout_id', value);

  String get exerciseId => getField<String>('exercise_id')!;
  set exerciseId(String value) => setField<String>('exercise_id', value);

  int? get orderIndex => getField<int>('order_index');
  set orderIndex(int? value) => setField<int>('order_index', value);

  String? get notes => getField<String>('notes');
  set notes(String? value) => setField<String>('notes', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
