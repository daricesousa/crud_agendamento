import 'package:crud_agendamento/app/core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';

class AppDateRange extends StatefulWidget {
  final DateTimeRange datesRange;
  final void Function(DateTimeRange) callback;

  const AppDateRange({
    super.key,
    required this.datesRange,
    required this.callback,
  });

  @override
  State<AppDateRange> createState() => _AppDateRangeState();
}

class _AppDateRangeState extends State<AppDateRange> {
  late DateTime start;
  late DateTime end;
  late CleanCalendarController calendar;

  @override
  void initState() {
    start = widget.datesRange.start;
    end = widget.datesRange.end;
    calendar = CleanCalendarController(
        maxDate: DateTime(
            DateTime.now().year, DateTime.now().month + 6, DateTime.now().day),
        minDate: DateTime(2023),
        initialFocusDate: start,
        initialDateSelected: start,
        endDateSelected: end,
        weekdayStart: DateTime.sunday,
        onRangeSelected: (a, b) {
          start = a;
          end = b ?? a;
        });
    super.initState();
  }

  @override
  void dispose() {
    calendar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 450, maxWidth: 400),
              child: ScrollableCleanCalendar(
                calendarController: calendar,
                locale: 'pt',
                weekdayTextStyle: context.textTheme.labelSmall,
                layout: Layout.BEAUTY,
                calendarCrossAxisSpacing: 0,
                dayRadius: 100,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 20,
              children: [
                AppButton(
                  label: "Cancelar",
                  onPressed: Get.back,
                ),
                AppButton(
                  label: "Filtrar",
                  onPressed: () {
                    final dateRange = DateTimeRange(
                      start: start,
                      end: end,
                    );
                    widget.callback.call(dateRange);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
