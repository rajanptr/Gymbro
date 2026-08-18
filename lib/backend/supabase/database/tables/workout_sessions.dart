import '../database.dart';

class WorkoutSessionsTable extends SupabaseTable<WorkoutSessionsRow> {
  @override
  String get tableName => 'workout_sessions';

  @override
  WorkoutSessionsRow createRow(Map<String, dynamic> data) =>
      WorkoutSessionsRow(data);
}

class WorkoutSessionsRow extends SupabaseDataRow {
  WorkoutSessionsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => WorkoutSessionsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  String get title => getField<String>('title')!;
  set title(String value) => setField<String>('title', value);

  String? get notes => getField<String>('notes');
  set notes(String? value) => setField<String>('notes', value);

  DateTime? get startedAt => getField<DateTime>('started_at');
  set startedAt(DateTime? value) => setField<DateTime>('started_at', value);

  DateTime? get finishedAt => getField<DateTime>('finished_at');
  set finishedAt(DateTime? value) => setField<DateTime>('finished_at', value);

  int? get durationSeconds => getField<int>('duration_seconds');
  set durationSeconds(int? value) => setField<int>('duration_seconds', value);

  bool? get isCompleted => getField<bool>('is_completed');
  set isCompleted(bool? value) => setField<bool>('is_completed', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get templateId => getField<String>('template_id');
  set templateId(String? value) => setField<String>('template_id', value);
}
