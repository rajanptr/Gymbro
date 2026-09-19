import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'flutter_flow_util.dart';

/// How the header names the month.
enum FlutterFlowCalendarCaptionLayout {
  /// A month and year label, e.g. "August 2026".
  label,

  /// Month and year dropdowns.
  dropdown,
}

/// What the user can select in a [FlutterFlowModernCalendar].
enum FlutterFlowCalendarSelectionMode {
  /// One date at a time.
  single,

  /// A start and an end date, picked in two taps.
  range,
}

/// Adds [days] to [date] via calendar arithmetic, so the result is unaffected
/// by daylight saving transitions.
DateTime _addDays(DateTime date, int days) =>
    DateTime(date.year, date.month, date.day + days);

DateTime _addMonths(DateTime date, int months) =>
    DateTime(date.year, date.month + months, date.day);

DateTime _startOfMonth(DateTime date) => DateTime(date.year, date.month);

DateTime _endOfMonth(DateTime date) => DateTime(date.year, date.month + 1, 0);

DateTime _startOfDay(DateTime date) =>
    DateTime(date.year, date.month, date.day);

DateTime _endOfDay(DateTime date) =>
    DateTime(date.year, date.month, date.day, 23, 59);

bool _isSameDay(DateTime? a, DateTime? b) =>
    a != null &&
    b != null &&
    a.year == b.year &&
    a.month == b.month &&
    a.day == b.day;

DateTime _previousWeek(DateTime week) => _addDays(week, -7);

DateTime _nextWeek(DateTime week) => _addDays(week, 7);

DateTime _previousMonth(DateTime month) => _addMonths(month, -1);

DateTime _nextMonth(DateTime month) => _addMonths(month, 1);

/// Justify has no meaning for a single line label, so it centres like the
/// default.
AlignmentGeometry _alignmentFor(TextAlign align) => switch (align) {
      TextAlign.left || TextAlign.start => AlignmentDirectional.centerStart,
      TextAlign.right || TextAlign.end => AlignmentDirectional.centerEnd,
      _ => Alignment.center,
    };

/// A compact calendar with square cells and a centered header, rendering its
/// own month grid rather than delegating to `table_calendar` so cells stay
/// square and the header can be laid out freely.
///
/// The layout follows the shadcn/ui calendar, and the date generation takes the
/// same approach as the shadcn_ui package (MIT, Alexandru Mariuti): walk back to
/// the start of the week, then emit days until the month is covered and the last
/// week is full.
class FlutterFlowModernCalendar extends StatefulWidget {
  const FlutterFlowModernCalendar({
    super.key,
    required this.color,
    this.onChange,
    this.initialDate,
    this.weekFormat = false,
    this.weekStartsMonday = false,
    this.iconColor,
    this.dateStyle,
    this.dayOfWeekStyle,
    this.inactiveDateStyle,
    this.selectedDateStyle,
    this.titleStyle,
    this.rowHeight,
    this.locale,
    this.captionLayout = FlutterFlowCalendarCaptionLayout.label,
    this.showOutsideDays = true,
    this.showWeekNumbers = false,
    this.fixedWeeks = false,
    this.monthsShown = 1,
    this.cellRadius,
    this.showNavigation = true,
    this.rangeColor,
    this.rangeBorderRadius,
    this.selectedBorderRadius,
    this.continuousRange = false,
    this.todayColor,
    this.todayDateStyle,
    this.selectionMode = FlutterFlowCalendarSelectionMode.single,
    this.initialRangeStart,
    this.initialRangeEnd,
    this.titleAlign,
    this.bookedDates = const <DateTime>[],
    this.bookedDateStyle,
  });

  final bool weekFormat;
  final bool weekStartsMonday;
  final Color color;
  final void Function(DateTimeRange?)? onChange;
  final DateTime? initialDate;
  final Color? iconColor;
  final TextStyle? dateStyle;
  final TextStyle? dayOfWeekStyle;
  final TextStyle? inactiveDateStyle;
  final TextStyle? selectedDateStyle;
  final TextStyle? titleStyle;
  final double? rowHeight;
  final String? locale;
  final FlutterFlowCalendarCaptionLayout captionLayout;
  final bool showOutsideDays;
  final bool showWeekNumbers;
  final bool fixedWeeks;
  final int monthsShown;
  final double? cellRadius;
  final bool showNavigation;

  /// The fill behind the days between the ends of a range. Defaults to the
  /// calendar's [color], lightened.
  final Color? rangeColor;

  /// The corner radius at the ends of a range. Defaults to the cell radius.
  final double? rangeBorderRadius;

  /// The corner radius of the selected date. Defaults to the cell radius.
  final double? selectedBorderRadius;

  /// Whether a range is drawn as one unbroken band rather than a tile per day.
  final bool continuousRange;

  /// The fill behind today, when it is not the selected date.
  final Color? todayColor;

  /// Today's text, when it is not the selected date. Defaults to the date style
  /// in the calendar's [color].
  final TextStyle? todayDateStyle;

  final FlutterFlowCalendarSelectionMode selectionMode;

  /// The range the calendar opens with, in
  /// [FlutterFlowCalendarSelectionMode.range].
  final DateTime? initialRangeStart;
  final DateTime? initialRangeEnd;

  /// Where the header's month sits. Defaults to centered, like shadcn/ui.
  final TextAlign? titleAlign;

  /// Dates that cannot be selected, for example days already booked.
  final List<DateTime> bookedDates;
  final TextStyle? bookedDateStyle;

  @override
  State<StatefulWidget> createState() => _FlutterFlowModernCalendarState();
}

class _FlutterFlowModernCalendarState extends State<FlutterFlowModernCalendar> {
  static const double _defaultCellSize = 40;
  static const double _defaultCellRadius = 8;
  static const int _weeksWhenFixed = 6;
  static const double _headerHeight = 38;
  static const double _headerBottomSpacing = 16;
  static const double _weekdaysBottomSpacing = 8;
  static const double _navButtonSize = 28;
  static const double _navIconSize = 20;
  static const double _monthSpacing = 16;
  static const double _captionGap = 8;
  static const double _weekNumberFontSize = 12.8;

  /// Years offered by the year dropdown, matching shadcn_ui's unbounded range.
  static const int _yearRange = 100;

  late DateTime focusedDay;

  /// Null until something is selected: a calendar opened without an initial
  /// date has no selection, so today is drawn as today rather than as selected.
  DateTime? selectedDay;
  DateTimeRange? selectedRange;

  /// Whether the user has picked a date in this calendar. Their selection
  /// outranks the initial values, which are only a starting point.
  bool hasUserSelected = false;

  /// The start of a range the user has begun but not finished. While this is
  /// set, the next tap completes the range.
  DateTime? pendingRangeStart;

  bool get isRangeMode =>
      widget.selectionMode == FlutterFlowCalendarSelectionMode.range;

  @override
  void initState() {
    super.initState();
    applyInitialSelection();
    reportInitialSelection();
  }

  /// Reports the selection the calendar was given, after the frame so a rebuild
  /// it triggers cannot land during one. Nothing is reported when nothing is
  /// selected: the date selected actions must not fire for a selection nobody
  /// made.
  void reportInitialSelection() {
    final selection = selectedRange;
    if (selection == null) {
      return;
    }
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => setSelectedDay(selection.start, selection.end),
    );
  }

  @override
  void didUpdateWidget(FlutterFlowModernCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // This widget is rebuilt in place both by the canvas, as its properties are
    // edited, and by a running app, when a bound initial value changes. The
    // values initState read are stale in both cases, but a selection the user
    // made is not: overwriting it would leave the calendar showing one date
    // while the page's state variable holds another, since re-seeding is
    // deliberately silent and reports nothing.
    if (hasUserSelected || !initialValuesChanged(oldWidget)) {
      return;
    }
    setState(applyInitialSelection);
    // Reported, the way initState reports what it opened with: leaving it
    // silent would show the new date while the page's state variable still
    // held the old one.
    reportInitialSelection();
  }

  /// Whether the values this calendar derives its selection from changed. Only
  /// the ones its selection mode reads count, so an initial date a range
  /// calendar ignores cannot clear its range.
  bool initialValuesChanged(FlutterFlowModernCalendar oldWidget) {
    if (oldWidget.selectionMode != widget.selectionMode ||
        !listEquals(oldWidget.bookedDates, widget.bookedDates)) {
      return true;
    }
    return isRangeMode
        ? oldWidget.initialRangeStart != widget.initialRangeStart ||
            oldWidget.initialRangeEnd != widget.initialRangeEnd ||
            // applyInitialSelection below falls back to initialDate for focus
            // only when no range start is preset, so only then does a change
            // to it matter. Comparing it regardless would re-seed, and
            // re-report, an unchanged range.
            (widget.initialRangeStart == null &&
                oldWidget.initialDate != widget.initialDate)
        : oldWidget.initialDate != widget.initialDate;
  }

  /// Derives the calendar's state from the initial date or range it was given,
  /// taking only the values that apply to its selection mode.
  void applyInitialSelection() {
    // Range mode selects from the initial range, but still opens on
    // `initialDate`'s month when no range is preset — a range calendar
    // given only an Initial Date used to ignore it and open on today.
    final initial = isRangeMode
        ? (widget.initialRangeStart ?? widget.initialDate)
        : widget.initialDate;
    focusedDay = initial ?? DateTime.now();
    final range = isRangeMode
        ? initialRange()
        : initial == null
            ? null
            : DateTimeRange(
                start: _startOfDay(initial),
                end: _endOfDay(initial),
              );
    selectedDay = range?.start;
    selectedRange = range;
    pendingRangeStart = null;
  }

  /// The range the calendar opens with, stopping at a booked date so that what
  /// it shows, and reports, never covers a day that cannot be selected. Null
  /// when either end is missing or the range starts on a booked date.
  DateTimeRange? initialRange() {
    final rangeStart = widget.initialRangeStart;
    final rangeEnd = widget.initialRangeEnd;
    if (rangeStart == null || rangeEnd == null) {
      return null;
    }
    final start = _startOfDay(rangeStart);
    var end = _startOfDay(rangeEnd);
    if (end.isBefore(start) || containsBookedDate(start, start)) {
      return null;
    }
    for (final booked in widget.bookedDates.map(_startOfDay)) {
      if (!booked.isBefore(start) && !booked.isAfter(end)) {
        final dayBefore = _addDays(booked, -1);
        if (dayBefore.isBefore(end)) {
          end = dayBefore;
        }
      }
    }
    return DateTimeRange(start: start, end: _endOfDay(end));
  }

  Color get color => widget.color;

  Color get todayColor => widget.todayColor ?? widget.color.applyAlpha(0.14);

  Color get rangeColor => widget.rangeColor ?? widget.color.applyAlpha(0.22);

  double get cellSize => widget.rowHeight != null && widget.rowHeight! > 0
      ? widget.rowHeight!
      : _defaultCellSize;

  double get cellCornerRadius => widget.cellRadius ?? _defaultCellRadius;

  double get rangeCornerRadius => widget.rangeBorderRadius ?? cellCornerRadius;

  double get selectedCornerRadius =>
      widget.selectedBorderRadius ?? cellCornerRadius;

  int get weekStart =>
      widget.weekStartsMonday ? DateTime.monday : DateTime.sunday;

  int get monthsShown =>
      widget.weekFormat ? 1 : widget.monthsShown.clamp(1, 12);

  double get monthWidth => cellSize * (widget.showWeekNumbers ? 8 : 7);

  /// Kept within the cell size so a compact calendar stays proportional.
  double get navButtonSize =>
      cellSize < _navButtonSize ? cellSize : _navButtonSize;

  double get headerHeight =>
      cellSize < _headerHeight ? cellSize : _headerHeight;

  void setSelectedDay(
    DateTime? newSelectedDay, [
    DateTime? newSelectedEnd,
  ]) {
    final newRange = newSelectedDay == null
        ? null
        : DateTimeRange(
            start: _startOfDay(newSelectedDay),
            end: newSelectedEnd ?? _endOfDay(newSelectedDay),
          );
    setState(() {
      selectedDay = newSelectedDay ?? selectedDay;
      selectedRange = newRange ?? selectedRange;
      if (widget.onChange != null) {
        widget.onChange!(newRange);
      }
    });
  }

  DateTime firstVisibleDayOf(DateTime month) {
    var first =
        widget.weekFormat ? _startOfDay(focusedDay) : _startOfMonth(month);
    while (first.weekday != weekStart) {
      first = _addDays(first, -1);
    }
    return first;
  }

  /// The grid for [month]. Entries are null where an outside day is hidden.
  List<DateTime?> visibleDaysOf(DateTime month) {
    final first = firstVisibleDayOf(month);
    if (widget.weekFormat) {
      return List<DateTime?>.generate(7, (index) => _addDays(first, index));
    }
    final lastOfMonth = _endOfMonth(month);
    final days = <DateTime?>[];
    var day = first;
    var coveredWholeMonth = false;
    while (!coveredWholeMonth ||
        days.length % 7 != 0 ||
        (widget.fixedWeeks && days.length < _weeksWhenFixed * 7)) {
      final isOutsideMonth = day.month != month.month;
      days.add(isOutsideMonth && !widget.showOutsideDays ? null : day);
      if (_isSameDay(day, lastOfMonth)) {
        coveredWholeMonth = true;
      }
      day = _addDays(day, 1);
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {
    final firstMonth = _startOfMonth(focusedDay);
    return Material(
      type: MaterialType.transparency,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (var index = 0; index < monthsShown; index++) ...[
            if (index > 0) const SizedBox(width: _monthSpacing),
            _buildMonth(
              _addMonths(firstMonth, index),
              index: index,
              isLast: index == monthsShown - 1,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMonth(
    DateTime month, {
    required int index,
    required bool isLast,
  }) {
    final days = visibleDaysOf(month);
    final weekStart = firstVisibleDayOf(month);
    return SizedBox(
      width: monthWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildCaption(month, index: index, isLast: isLast),
          _buildDaysOfWeek(weekStart),
          for (var i = 0; i < days.length; i += 7)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (widget.showWeekNumbers)
                  _buildWeekNumber(days.sublist(i, i + 7)),
                ...days.sublist(i, i + 7).indexed.map(
                      (entry) => _buildDay(
                        entry.$2,
                        month,
                        isRowStart: entry.$1 == 0,
                        isRowEnd: entry.$1 == 6,
                      ),
                    ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildCaption(
    DateTime month, {
    required int index,
    required bool isLast,
  }) {
    final showsBack = widget.showNavigation && index == 0;
    final showsForward = widget.showNavigation && isLast;
    final titleAlign = widget.titleAlign ?? TextAlign.center;
    final label =
        widget.captionLayout == FlutterFlowCalendarCaptionLayout.dropdown
            ? _buildCaptionDropdowns(month, index)
            : Text(
                DateFormat.yMMMM(widget.locale).format(month),
                textAlign: titleAlign,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ).merge(widget.titleStyle),
              );
    return Container(
      height: headerHeight + _headerBottomSpacing,
      padding: const EdgeInsets.only(bottom: _headerBottomSpacing),
      child: Row(
        children: <Widget>[
          showsBack
              ? _buildNavButton(
                  Icons.chevron_left,
                  () => setState(
                    () => focusedDay = widget.weekFormat
                        ? _previousWeek(focusedDay)
                        : _previousMonth(focusedDay),
                  ),
                )
              : SizedBox(width: navButtonSize),
          Expanded(
            child: Align(
              alignment: _alignmentFor(titleAlign),
              child: label,
            ),
          ),
          showsForward
              ? _buildNavButton(
                  Icons.chevron_right,
                  () => setState(
                    () => focusedDay = widget.weekFormat
                        ? _nextWeek(focusedDay)
                        : _nextMonth(focusedDay),
                  ),
                )
              : SizedBox(width: navButtonSize),
        ],
      ),
    );
  }

  /// Month and year dropdowns, as shadcn/ui's `captionLayout: "dropdown"`. A
  /// selection is applied to the month at [index], so the months either side of
  /// it shift with it and the row stays contiguous.
  Widget _buildCaptionDropdowns(DateTime month, int index) {
    final textStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ).merge(widget.titleStyle);
    void jumpTo(int year, int monthNumber) => setState(
          () => focusedDay = _addMonths(DateTime(year, monthNumber), -index),
        );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildDropdown<int>(
          value: month.month,
          textStyle: textStyle,
          items: List<int>.generate(12, (i) => i + 1),
          labelOf: (value) =>
              DateFormat.MMM(widget.locale).format(DateTime(month.year, value)),
          onChanged: (value) => jumpTo(month.year, value),
        ),
        const SizedBox(width: _captionGap),
        _buildDropdown<int>(
          value: month.year,
          textStyle: textStyle,
          items: List<int>.generate(
            _yearRange * 2 + 1,
            (i) => month.year - _yearRange + i,
          ),
          labelOf: (value) => value.toString(),
          onChanged: (value) => jumpTo(value, month.month),
        ),
      ],
    );
  }

  Widget _buildDropdown<T>({
    required T value,
    required List<T> items,
    required String Function(T value) labelOf,
    required TextStyle textStyle,
    required void Function(T value) onChanged,
  }) =>
      DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isDense: true,
          borderRadius: BorderRadius.circular(cellCornerRadius),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            size: _navIconSize,
            color: widget.iconColor,
          ),
          style: textStyle,
          items: items
              .map(
                (item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(labelOf(item), style: textStyle),
                ),
              )
              .toList(),
          onChanged: (selected) {
            if (selected != null) {
              onChanged(selected);
            }
          },
        ),
      );

  Widget _buildNavButton(IconData icon, VoidCallback onTap) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(cellCornerRadius),
        hoverColor: todayColor,
        child: SizedBox(
          width: navButtonSize,
          height: navButtonSize,
          child: Icon(
            icon,
            size: _navIconSize,
            color: widget.iconColor,
          ),
        ),
      );

  Widget _buildDaysOfWeek(DateTime weekStart) => Padding(
        padding: const EdgeInsets.only(bottom: _weekdaysBottomSpacing),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // shadcn/ui heads the week number column with a '#'.
            if (widget.showWeekNumbers)
              SizedBox(
                width: cellSize,
                child: Text(
                  '#',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: _weekNumberFontSize,
                    color: Color(0xFF9E9E9E),
                  ).merge(widget.inactiveDateStyle),
                ),
              ),
            ...List<Widget>.generate(
              7,
              (index) => SizedBox(
                width: cellSize,
                child: Text(
                  weekdayLabel(_addDays(weekStart, index)),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF616161),
                  ).merge(widget.dayOfWeekStyle),
                ),
              ),
            ),
          ],
        ),
      );

  /// Two-character weekday label, matching the shadcn/ui calendar (Su, Mo, ...).
  String weekdayLabel(DateTime day) {
    final label = DateFormat.E(widget.locale).format(day);
    return label.length <= 2 ? label : label.substring(0, 2);
  }

  Widget _buildWeekNumber(List<DateTime?> week) {
    final day = week.firstWhere((day) => day != null, orElse: () => null);
    return SizedBox(
      width: cellSize,
      height: cellSize,
      child: Center(
        child: Text(
          day == null ? '' : weekNumberOf(day).toString(),
          style: const TextStyle(
            fontSize: _weekNumberFontSize,
            color: Color(0xFF9E9E9E),
          ).merge(widget.inactiveDateStyle),
        ),
      ),
    );
  }

  /// ISO 8601 week number: week 1 is the week holding the year's first Thursday.
  int weekNumberOf(DateTime day) {
    final utcDay = DateTime.utc(day.year, day.month, day.day);
    final thursday = utcDay.add(Duration(days: 4 - utcDay.weekday));
    final firstOfYear = DateTime.utc(thursday.year);
    return thursday.difference(firstOfYear).inDays ~/ 7 + 1;
  }

  /// The range currently drawn: a finished range, or the single pending start
  /// while the user is mid selection.
  DateTimeRange? get drawnRange {
    if (!isRangeMode) {
      return null;
    }
    final pending = pendingRangeStart;
    if (pending != null) {
      return DateTimeRange(
        start: _startOfDay(pending),
        end: _endOfDay(pending),
      );
    }
    return selectedRange;
  }

  void selectRangeDay(DateTime day) {
    hasUserSelected = true;
    final pending = pendingRangeStart;
    if (pending == null) {
      // Starting a range: nothing is reported until it has both ends.
      setState(() => pendingRangeStart = _startOfDay(day));
      return;
    }
    final isBeforeStart = _startOfDay(day).isBefore(pending);
    final start = isBeforeStart ? day : pending;
    final end = isBeforeStart ? pending : day;
    if (containsBookedDate(start, end)) {
      // A booked date is a hard stop: a range can never contain one, so this
      // tap starts a new range at the day it landed on rather than completing
      // one across a day that cannot be selected.
      setState(() => pendingRangeStart = _startOfDay(day));
      return;
    }
    setState(() => pendingRangeStart = null);
    setSelectedDay(start, _endOfDay(end));
  }

  /// Brings [day]'s month into view when it is not already, so tapping an
  /// outside day leaves the selection inside a grid rather than at the edge of
  /// one, as shadcn/ui does. A day already on screen in one of the months shown
  /// moves nothing.
  void showMonthOf(DateTime day) {
    if (widget.weekFormat) {
      return;
    }
    final firstShown = _startOfMonth(focusedDay);
    final month = _startOfMonth(day);
    if (!month.isBefore(firstShown) &&
        month.isBefore(_addMonths(firstShown, monthsShown))) {
      return;
    }
    setState(() => focusedDay = month);
  }

  /// Whether any booked date falls within [start] to [end], inclusive.
  bool containsBookedDate(DateTime start, DateTime end) {
    final from = _startOfDay(start);
    final to = _startOfDay(end);
    return widget.bookedDates.map(_startOfDay).any(
          (booked) => !booked.isBefore(from) && !booked.isAfter(to),
        );
  }

  /// The rounding for one day's cell: every day of a range follows the range
  /// radius, the selected date its own, and everything else the cell radius.
  /// Continuous ranges do not change this, so a day is the same shape and size
  /// either way; only the band behind it differs.
  BorderRadius borderRadiusFor({
    required bool isInRange,
    required bool isSelected,
  }) =>
      BorderRadius.circular(
        isInRange
            ? rangeCornerRadius
            : isSelected
                ? selectedCornerRadius
                : cellCornerRadius,
      );

  /// The rounding of the band drawn behind a continuous range: square where the
  /// range carries on into the next cell, rounded where it stops.
  BorderRadius bandRadiusFor({
    required bool isLeadingEdge,
    required bool isTrailingEdge,
  }) {
    final radius = Radius.circular(rangeCornerRadius);
    return BorderRadius.horizontal(
      left: isLeadingEdge ? radius : Radius.zero,
      right: isTrailingEdge ? radius : Radius.zero,
    );
  }

  Widget _buildDay(
    DateTime? day,
    DateTime month, {
    required bool isRowStart,
    required bool isRowEnd,
  }) {
    if (day == null) {
      return SizedBox(width: cellSize, height: cellSize);
    }
    final isBooked =
        widget.bookedDates.any((booked) => _isSameDay(booked, day));
    final range = drawnRange;
    final isRangeStart = range != null && _isSameDay(range.start, day);
    final isRangeEnd = range != null && _isSameDay(range.end, day);
    final isWithinRange = range != null &&
        !isRangeStart &&
        !isRangeEnd &&
        _startOfDay(day).isAfter(range.start) &&
        _startOfDay(day).isBefore(range.end);
    final isSelected = !isBooked &&
        (isRangeMode
            ? isRangeStart || isRangeEnd
            : _isSameDay(selectedDay, day));
    final isToday = _isSameDay(DateTime.now(), day);
    final isOutsideMonth = !widget.weekFormat && day.month != month.month;
    final baseStyle = isOutsideMonth
        ? const TextStyle(color: Color(0xFF9E9E9E)).merge(
            widget.inactiveDateStyle,
          )
        : const TextStyle(color: Color(0xFF5A5A5A)).merge(widget.dateStyle);
    if (isBooked) {
      return SizedBox(
        width: cellSize,
        height: cellSize,
        child: Center(
          child: Text(
            day.day.toString(),
            style: const TextStyle(
              color: Color(0xFF9E9E9E),
              decoration: TextDecoration.lineThrough,
            ).merge(widget.bookedDateStyle),
          ),
        ),
      );
    }
    final isInRangeBand = isWithinRange || isRangeStart || isRangeEnd;
    // A row break ends the band visually, so it is treated as an edge too.
    final isLeadingEdge = isRangeStart || isRowStart;
    final isTrailingEdge = isRangeEnd || isRowEnd;
    final borderRadius = borderRadiusFor(
      isInRange: isInRangeBand,
      isSelected: isSelected,
    );
    return SizedBox(
      width: cellSize,
      height: cellSize,
      child: Stack(
        children: [
          // A continuous range runs as one band behind the cells, the whole
          // width of each one including its ends, so the gaps their rounded
          // corners would leave are filled rather than showing through. The
          // cells themselves keep the same size and rounding as in a range
          // that is not continuous.
          if (widget.continuousRange && isInRangeBand)
            Positioned.fill(
              child: Padding(
                // Inset to the cells' own bounds, so the band bridges the gaps
                // between them without haloing outside the range's rounded
                // ends. Only the edges it carries on through stay flush.
                padding: EdgeInsets.only(
                  top: 1,
                  bottom: 1,
                  left: isLeadingEdge ? 1 : 0,
                  right: isTrailingEdge ? 1 : 0,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: rangeColor,
                    borderRadius: bandRadiusFor(
                      isLeadingEdge: isLeadingEdge,
                      isTrailingEdge: isTrailingEdge,
                    ),
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(1),
            child: Material(
              // Inside a continuous range the band is the only fill: painting
              // the cell as well would double up a translucent range colour and
              // show each day as its own tile over the band.
              color: isSelected
                  ? color
                  : isWithinRange && !widget.continuousRange
                      ? rangeColor
                      : isToday
                          ? todayColor
                          : Colors.transparent,
              borderRadius: borderRadius,
              child: InkWell(
                onTap: () {
                  showMonthOf(day);
                  if (isRangeMode) {
                    selectRangeDay(day);
                    return;
                  }
                  hasUserSelected = true;
                  setSelectedDay(day);
                },
                borderRadius: borderRadius,
                hoverColor: todayColor,
                child: Center(
                  child: Text(
                    day.day.toString(),
                    style: isSelected
                        ? const TextStyle(
                            color: Color(0xFFFAFAFA),
                            fontSize: 14,
                          ).merge(widget.selectedDateStyle)
                        : isToday
                            ? widget.todayDateStyle ??
                                baseStyle.copyWith(color: color)
                            : baseStyle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
