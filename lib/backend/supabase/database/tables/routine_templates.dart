import '../database.dart';

class RoutineTemplatesTable extends SupabaseTable<RoutineTemplatesRow> {
  @override
  String get tableName => 'routine_templates';

  @override
  RoutineTemplatesRow createRow(Map<String, dynamic> data) =>
      RoutineTemplatesRow(data);
}

class RoutineTemplatesRow extends SupabaseDataRow {
  RoutineTemplatesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RoutineTemplatesTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  String? get notes => getField<String>('notes');
  set notes(String? value) => setField<String>('notes', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
