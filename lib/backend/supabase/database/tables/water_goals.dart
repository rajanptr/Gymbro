import '../database.dart';

class WaterGoalsTable extends SupabaseTable<WaterGoalsRow> {
  @override
  String get tableName => 'water_goals';

  @override
  WaterGoalsRow createRow(Map<String, dynamic> data) => WaterGoalsRow(data);
}

class WaterGoalsRow extends SupabaseDataRow {
  WaterGoalsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => WaterGoalsTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String get userId => getField<String>('user_id')!;
  set userId(String value) => setField<String>('user_id', value);

  int? get dailyGoalMl => getField<int>('daily_goal_ml');
  set dailyGoalMl(int? value) => setField<int>('daily_goal_ml', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');
  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);
}
