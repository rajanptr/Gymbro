import '../database.dart';

class ProfilesTable extends SupabaseTable<ProfilesRow> {
  @override
  String get tableName => 'profiles';

  @override
  ProfilesRow createRow(Map<String, dynamic> data) => ProfilesRow(data);
}

class ProfilesRow extends SupabaseDataRow {
  ProfilesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ProfilesTable();

  String? get id => getField<String>('id');
  set id(String? value) => setField<String>('id', value);

  String? get username => getField<String>('username');
  set username(String? value) => setField<String>('username', value);

  String? get avatarUrl => getField<String>('avatar_url');
  set avatarUrl(String? value) => setField<String>('avatar_url', value);

  String? get gender => getField<String>('gender');
  set gender(String? value) => setField<String>('gender', value);

  DateTime? get birthDate => getField<DateTime>('birth_date');
  set birthDate(DateTime? value) => setField<DateTime>('birth_date', value);

  double? get heightCm => getField<double>('height_cm');
  set heightCm(double? value) => setField<double>('height_cm', value);

  double? get weightKg => getField<double>('weight_kg');
  set weightKg(double? value) => setField<double>('weight_kg', value);

  String? get preferredUnit => getField<String>('preferred_unit');
  set preferredUnit(String? value) => setField<String>('preferred_unit', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
