import '../database.dart';

class WorkoutExerciseDetailsTable
    extends SupabaseTable<WorkoutExerciseDetailsRow> {
  @override
  String get tableName => 'workout_exercise_details';

  @override
  WorkoutExerciseDetailsRow createRow(Map<String, dynamic> data) =>
      WorkoutExerciseDetailsRow(data);
}

class WorkoutExerciseDetailsRow extends SupabaseDataRow {
  WorkoutExerciseDetailsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => WorkoutExerciseDetailsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get workoutId => getField<String>('workout_id');
  set workoutId(String? value) => setField<String>('workout_id', value);

  int? get orderIndex => getField<int>('order_index');
  set orderIndex(int? value) => setField<int>('order_index', value);

  String? get exerciseId => getField<String>('exercise_id');
  set exerciseId(String? value) => setField<String>('exercise_id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get muscleGroup => getField<String>('muscle_group');
  set muscleGroup(String? value) => setField<String>('muscle_group', value);

  String? get equipment => getField<String>('equipment');
  set equipment(String? value) => setField<String>('equipment', value);

  int? get plannedSets => getField<int>('planned_sets');
  set plannedSets(int? value) => setField<int>('planned_sets', value);

  int? get completedSets => getField<int>('completed_sets');
  set completedSets(int? value) => setField<int>('completed_sets', value);

  String? get status => getField<String>('status');
  set status(String? value) => setField<String>('status', value);
}
