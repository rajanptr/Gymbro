import '../database.dart';

class WaterLogsTable extends SupabaseTable<WaterLogsRow> {
  @override
  String get tableName => 'water_logs';

  @override
  WaterLogsRow createRow(Map<String, dynamic> data) => WaterLogsRow(data);
}

class WaterLogsRow extends SupabaseDataRow {
  WaterLogsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => WaterLogsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  int get amountMl => getField<int>('amount_ml')!;
  set amountMl(int value) => setField<int>('amount_ml', value);

  DateTime? get loggedAt => getField<DateTime>('logged_at');
  set loggedAt(DateTime? value) => setField<DateTime>('logged_at', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  DateTime? get logDate => getField<DateTime>('log_date');
  set logDate(DateTime? value) => setField<DateTime>('log_date', value);
}
