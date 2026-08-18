import '../database.dart';

class SavedRoutinesTable extends SupabaseTable<SavedRoutinesRow> {
  @override
  String get tableName => 'saved_routines';

  @override
  SavedRoutinesRow createRow(Map<String, dynamic> data) =>
      SavedRoutinesRow(data);
}

class SavedRoutinesRow extends SupabaseDataRow {
  SavedRoutinesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => SavedRoutinesTable();

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
