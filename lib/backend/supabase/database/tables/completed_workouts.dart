import '../database.dart';

class CompletedWorkoutsTable extends SupabaseTable<CompletedWorkoutsRow> {
  @override
  String get tableName => 'completed_workouts';

  @override
  CompletedWorkoutsRow createRow(Map<String, dynamic> data) =>
      CompletedWorkoutsRow(data);
}

class CompletedWorkoutsRow extends SupabaseDataRow {
  CompletedWorkoutsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => CompletedWorkoutsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String get workoutId => getField<String>('workout_id')!;
  set workoutId(String value) => setField<String>('workout_id', value);

  String get workoutName => getField<String>('workout_name')!;
  set workoutName(String value) => setField<String>('workout_name', value);

  DateTime get startedAt => getField<DateTime>('started_at')!;
  set startedAt(DateTime value) => setField<DateTime>('started_at', value);

  DateTime get endedAt => getField<DateTime>('ended_at')!;
  set endedAt(DateTime value) => setField<DateTime>('ended_at', value);

  int? get durationSeconds => getField<int>('duration_seconds');
  set durationSeconds(int? value) => setField<int>('duration_seconds', value);

  int? get totalExercises => getField<int>('total_exercises');
  set totalExercises(int? value) => setField<int>('total_exercises', value);

  int? get totalSets => getField<int>('total_sets');
  set totalSets(int? value) => setField<int>('total_sets', value);

  int? get totalReps => getField<int>('total_reps');
  set totalReps(int? value) => setField<int>('total_reps', value);

  int? get totalVolume => getField<int>('total_volume');
  set totalVolume(int? value) => setField<int>('total_volume', value);

  int? get totalPrs => getField<int>('total_prs');
  set totalPrs(int? value) => setField<int>('total_prs', value);

  String? get notes => getField<String>('notes');
  set notes(String? value) => setField<String>('notes', value);

  int? get workoutRating => getField<int>('workout_rating');
  set workoutRating(int? value) => setField<int>('workout_rating', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);
}
