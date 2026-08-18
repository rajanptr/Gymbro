import '../database.dart';

class RoutineExercisesTable extends SupabaseTable<RoutineExercisesRow> {
  @override
  String get tableName => 'routine_exercises';

  @override
  RoutineExercisesRow createRow(Map<String, dynamic> data) =>
      RoutineExercisesRow(data);
}

class RoutineExercisesRow extends SupabaseDataRow {
  RoutineExercisesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RoutineExercisesTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String get templateId => getField<String>('template_id')!;
  set templateId(String value) => setField<String>('template_id', value);

  String get exerciseId => getField<String>('exercise_id')!;
  set exerciseId(String value) => setField<String>('exercise_id', value);

  int? get orderIndex => getField<int>('order_index');
  set orderIndex(int? value) => setField<int>('order_index', value);
}
