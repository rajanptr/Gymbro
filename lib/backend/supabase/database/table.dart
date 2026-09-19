import 'database.dart';

abstract class SupabaseTable<T extends SupabaseDataRow> {
  String get tableName;
  T createRow(Map<String, dynamic> data);

  PostgrestFilterBuilder _select() => SupaFlow.client.from(tableName).select();

  Future<List<T>> queryRows({
    required PostgrestTransformBuilder Function(PostgrestFilterBuilder) queryFn,
    int? limit,
  }) {
    final select = _select();
    var query = queryFn(select);
    query = limit != null ? query.limit(limit) : query;
    return query.select().then((rows) => rows.map(createRow).toList());
  }

  /// Fetches one page of rows, starting at row [offset] and returning at most
  /// [pageSize] rows. A page shorter than [pageSize] means the query is
  /// exhausted.
  Future<List<T>> queryRowsPage({
    required PostgrestTransformBuilder Function(PostgrestFilterBuilder) queryFn,
    required int offset,
    required int pageSize,
  }) {
    final select = _select();
    return queryFn(select)
        .range(offset, offset + pageSize - 1)
        .select()
        .then((rows) => rows.map(createRow).toList());
  }

  Future<List<T>> querySingleRow({
    required PostgrestTransformBuilder Function(PostgrestFilterBuilder) queryFn,
  }) =>
      queryFn(_select())
          .limit(1)
          .select()
          .maybeSingle()
          .catchError((e) => print('Error querying row: $e'))
          .then((r) => [if (r != null) createRow(r)]);

  Future<T> insert(Map<String, dynamic> data) => SupaFlow.client
      .from(tableName)
      .insert(data)
      .select()
      .limit(1)
      .single()
      .then(createRow);

  Future<T> upsert(Map<String, dynamic> data, {String? onConflict}) =>
      SupaFlow.client
          .from(tableName)
          .upsert(data, onConflict: onConflict)
          .select()
          .limit(1)
          .single()
          .then(createRow);

  Future<List<T>> update({
    required Map<String, dynamic> data,
    required PostgrestTransformBuilder Function(PostgrestFilterBuilder)
        matchingRows,
    bool returnRows = false,
  }) async {
    final update = matchingRows(SupaFlow.client.from(tableName).update(data));
    if (!returnRows) {
      await update;
      return [];
    }
    return update.select().then((rows) => rows.map(createRow).toList());
  }

  Future<List<T>> delete({
    required PostgrestTransformBuilder Function(PostgrestFilterBuilder)
        matchingRows,
    bool returnRows = false,
  }) async {
    final delete = matchingRows(SupaFlow.client.from(tableName).delete());
    if (!returnRows) {
      await delete;
      return [];
    }
    return delete.select().then((rows) => rows.map(createRow).toList());
  }
}

/// Serializes a full-text search value for use inside a raw PostgREST
/// `or=(...)` filter string. The value is double-quoted with quotes and
/// backslashes escaped, so reserved PostgREST characters (commas, dots,
/// parentheses) in user input cannot terminate or extend the filter
/// expression. Null or blank input becomes an empty search, which matches
/// no rows - the OR-identity, mirroring how textSearchOrNull skips the
/// filter in AND chains.
String ftsOrFilterValue(String? query) {
  final escaped =
      (query?.trim() ?? '').replaceAll(r'\', r'\\').replaceAll('"', r'\"');
  return '"$escaped"';
}

extension NullSafePostgrestFilters on PostgrestFilterBuilder {
  PostgrestFilterBuilder eqOrNull(String column, dynamic value) {
    return value != null ? eq(column, value) : this;
  }

  PostgrestFilterBuilder neqOrNull(String column, dynamic value) {
    return value != null ? neq(column, value) : this;
  }

  PostgrestFilterBuilder ltOrNull(String column, dynamic value) {
    return value != null ? lt(column, value) : this;
  }

  PostgrestFilterBuilder lteOrNull(String column, dynamic value) {
    return value != null ? lte(column, value) : this;
  }

  PostgrestFilterBuilder gtOrNull(String column, dynamic value) {
    return value != null ? gt(column, value) : this;
  }

  PostgrestFilterBuilder gteOrNull(String column, dynamic value) {
    return value != null ? gte(column, value) : this;
  }

  PostgrestFilterBuilder containsOrNull(String column, dynamic value) {
    return value != null ? contains(column, value) : this;
  }

  PostgrestFilterBuilder overlapsOrNull(String column, dynamic value) {
    return value != null ? overlaps(column, value) : this;
  }

  PostgrestFilterBuilder inFilterOrNull(String column, List<dynamic>? values) {
    return values != null ? inFilter(column, values) : this;
  }

  PostgrestFilterBuilder textSearchOrNull(
    String column,
    String? query, {
    String? config,
    TextSearchType? type,
  }) {
    return query != null && query.trim().isNotEmpty
        ? textSearch(column, query, config: config, type: type)
        : this;
  }

  /// Full-text search for update/delete matching-rows filters. Unlike
  /// [textSearchOrNull], a null or blank [query] must not remove the
  /// predicate - that would turn "mutate matching rows" into "mutate every
  /// visible row". A blank query is sent as an empty search instead, which
  /// matches no rows, so the mutation affects nothing.
  PostgrestFilterBuilder requiredTextSearch(
    String column,
    String? query, {
    String? config,
    TextSearchType? type,
  }) {
    return textSearch(column, query?.trim() ?? '', config: config, type: type);
  }
}

extension NullSafeSupabaseStreamFilters on SupabaseStreamFilterBuilder {
  SupabaseStreamBuilder eqOrNull(String column, dynamic value) {
    return value != null ? eq(column, value) : this;
  }

  SupabaseStreamBuilder neqOrNull(String column, dynamic value) {
    return value != null ? neq(column, value) : this;
  }

  SupabaseStreamBuilder ltOrNull(String column, dynamic value) {
    return value != null ? lt(column, value) : this;
  }

  SupabaseStreamBuilder lteOrNull(String column, dynamic value) {
    return value != null ? lte(column, value) : this;
  }

  SupabaseStreamBuilder gtOrNull(String column, dynamic value) {
    return value != null ? gt(column, value) : this;
  }

  SupabaseStreamBuilder gteOrNull(String column, dynamic value) {
    return value != null ? gte(column, value) : this;
  }

  SupabaseStreamBuilder inFilterOrNull(String column, List<Object>? values) {
    return values != null ? inFilter(column, values) : this;
  }
}

/// Escapes one scalar value for use inside a raw PostgREST logic-tree filter
/// string (`or=(...)`, and any nested `and(...)` / `or(...)` inside it).
///
/// Inside a logic tree PostgREST treats `,` `.` `(` `)` `:` and leading or
/// trailing whitespace as structural. Double quotes make all of them literal;
/// inside the quotes only `"` and `\` need escaping. Numbers and booleans are
/// emitted bare so the server casts them exactly as on the chained-builder
/// path. Never pass an IS / IS NOT token through here: `is."null"` is invalid.
String orFilterValue(Object? value) {
  if (value == null) return '""';
  if (value is bool || value is num) return '$value';
  if (value is DateTime) return orFilterValue(value.toIso8601String());
  final escaped = '$value'.replaceAll(r'\', r'\\').replaceAll('"', r'\"');
  return '"$escaped"';
}

/// `{a,b,c}` array body for the `cs` / `ov` operators inside a logic tree.
String orFilterArrayBody(Object? value) => value is Iterable
    ? '{${value.map(orFilterValue).join(',')}}'
    : '{${orFilterValue(value)}}';

/// One `column.operator.value` term, or null when the term must be dropped
/// because its runtime value is null. Dropping mirrors the chained-builder
/// path, where eqOrNull skips a null-valued predicate: a leaf with no value is
/// not authored right now, so it contributes nothing.
String? orFilterLeaf(String column, String operator, Object? value) =>
    value == null ? null : '$column.$operator.${orFilterValue(value)}';

String? orFilterInLeaf(String column, Iterable<Object?>? values) =>
    values == null
        ? null
        : '$column.in.(${values.map(orFilterValue).join(',')})';

String? orFilterArrayLeaf(String column, String operator, Object? value) =>
    value == null ? null : '$column.$operator.${orFilterArrayBody(value)}';

/// Full-text search inside a logic tree. Dropped when the query is blank, the
/// same way textSearchOrNull skips an empty search box on the chained path: an
/// empty tsquery matches no rows, which would silently annihilate the AND group
/// it sits in. On update/delete matching-rows queries the drop is what makes
/// orFilterGroup collapse the whole AND group to its noMatch contradiction, so
/// mutations still fail closed.
String? orFilterTextSearchLeaf(String column, String operator, String? query) =>
    query == null || query.trim().isEmpty
        ? null
        : '$column.$operator.${ftsOrFilterValue(query)}';

/// A predicate that matches no rows on any column, nullable or not. PostgREST
/// has no constant-false literal, and a value cannot be both null and not null.
String orFilterNoMatch(String column) =>
    'and($column.is.null,$column.not.is.null)';

/// Joins [terms] into a logic-tree body.
///
/// Reads (noMatch == null): null terms are dropped; an empty group disappears
/// entirely, because `and()` / `or()` with an empty body is a 400.
///
/// Update/delete matching-rows queries (noMatch != null): a dropped conjunct
/// would WIDEN an AND group and mutate rows the user did not select, so any
/// dropped term collapses the whole AND group to [noMatch]. Dropping a
/// disjunct from an OR group only narrows, so it stays safe.
String? orFilterGroup(
  List<String?> terms, {
  required bool isAnd,
  String? noMatch,
}) {
  if (isAnd && noMatch != null && terms.any((t) => t == null)) return noMatch;
  final kept = terms.whereType<String>().toList();
  if (kept.isEmpty) return noMatch;
  if (kept.length == 1) return kept.single;
  return '${isAnd ? 'and' : 'or'}(${kept.join(',')})';
}

extension RawPostgrestGroupFilters on PostgrestFilterBuilder {
  /// Applies a logic-tree body. A null body means every leaf was dropped, i.e.
  /// no constraint - correct for a read query.
  PostgrestFilterBuilder orGroupOrNull(String? body) =>
      body == null ? this : or(body);

  /// Fail-closed variant for update/delete matching-rows queries: a fully
  /// dropped group must never widen the mutation to every visible row.
  PostgrestFilterBuilder requiredOrGroup(String? body, String noMatch) =>
      or(body ?? noMatch);
}

class PostgresTime {
  PostgresTime(this.time);
  DateTime? time;

  static PostgresTime? tryParse(String formattedString) {
    final datePrefix = DateTime.now().toIso8601String().split('T').first;
    return PostgresTime(
        DateTime.tryParse('${datePrefix}T$formattedString')?.toLocal());
  }

  String? toIso8601String() {
    return time?.toIso8601String().split('T').last;
  }

  @override
  String toString() {
    return toIso8601String() ?? '';
  }
}
