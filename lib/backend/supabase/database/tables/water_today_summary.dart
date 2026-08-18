import '../database.dart';

class WaterTodaySummaryTable extends SupabaseTable<WaterTodaySummaryRow> {
  @override
  String get tableName => 'water_today_summary';

  @override
  WaterTodaySummaryRow createRow(Map<String, dynamic> data) =>
      WaterTodaySummaryRow(data);
}

class WaterTodaySummaryRow extends SupabaseDataRow {
  WaterTodaySummaryRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => WaterTodaySummaryTable();

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  DateTime? get logDate => getField<DateTime>('log_date');
  set logDate(DateTime? value) => setField<DateTime>('log_date', value);

  int? get totalMl => getField<int>('total_ml');
  set totalMl(int? value) => setField<int>('total_ml', value);
}
