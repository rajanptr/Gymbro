import '../database.dart';

class ExerciseLibraryTable extends SupabaseTable<ExerciseLibraryRow> {
  @override
  String get tableName => 'exercise_library';

  @override
  ExerciseLibraryRow createRow(Map<String, dynamic> data) =>
      ExerciseLibraryRow(data);
}

class ExerciseLibraryRow extends SupabaseDataRow {
  ExerciseLibraryRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ExerciseLibraryTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  String? get muscleGroup => getField<String>('muscle_group');
  set muscleGroup(String? value) => setField<String>('muscle_group', value);

  String? get equipment => getField<String>('equipment');
  set equipment(String? value) => setField<String>('equipment', value);

  bool? get isCustom => getField<bool>('is_custom');
  set isCustom(bool? value) => setField<bool>('is_custom', value);

  String? get createdBy => getField<String>('created_by');
  set createdBy(String? value) => setField<String>('created_by', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get primaryMuscle => getField<String>('primary_muscle');
  set primaryMuscle(String? value) => setField<String>('primary_muscle', value);

  String? get exerciseType => getField<String>('exercise_type');
  set exerciseType(String? value) => setField<String>('exercise_type', value);

  String? get trackingMode => getField<String>('tracking_mode');
  set trackingMode(String? value) => setField<String>('tracking_mode', value);

  String? get imageUrl => getField<String>('image_url');
  set imageUrl(String? value) => setField<String>('image_url', value);

  String? get videoUrl => getField<String>('video_url');
  set videoUrl(String? value) => setField<String>('video_url', value);
}
