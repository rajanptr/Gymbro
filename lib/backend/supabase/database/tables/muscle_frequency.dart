import '../database.dart';

class MuscleFrequencyTable extends SupabaseTable<MuscleFrequencyRow> {
  @override
  String get tableName => 'muscle_frequency';

  @override
  MuscleFrequencyRow createRow(Map<String, dynamic> data) =>
      MuscleFrequencyRow(data);
}

class MuscleFrequencyRow extends SupabaseDataRow {
  MuscleFrequencyRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => MuscleFrequencyTable();

  String? get userId => getField<String>('user_id');
  set userId(String? value) => setField<String>('user_id', value);

  String? get primaryMuscle => getField<String>('primary_muscle');
  set primaryMuscle(String? value) => setField<String>('primary_muscle', value);

  int? get totalSets => getField<int>('total_sets');
  set totalSets(int? value) => setField<int>('total_sets', value);
}
