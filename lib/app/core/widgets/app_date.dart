import 'package:crud_agendamento/app/core/utils/formatters.dart';
import 'package:crud_agendamento/app/core/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:get/get.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';

class AppDate extends StatefulWidget {
  final String label;
  final DateTime? initial;
  final void Function(DateTime) callback;
  const AppDate({
    super.key,
    required this.callback,
    this.label = "",
    this.initial,
  });

  @override
  State<AppDate> createState() => _AppDateState();
}

class _AppDateState extends State<AppDate> {
  final time = ValueNotifier<DateTime?>(null);
  final now = DateTime.now();

  @override
  void dispose() {
    time.dispose();
    super.dispose();
  }

  @override
  void initState() {
    time.value = widget.initial;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = widget.initial ?? now;
    return GestureDetector(
      onTap: () async {
        final calendar = CleanCalendarController(
            maxDate: DateTime(DateTime.now().year, DateTime.now().month + 6,
                DateTime.now().day),
            minDate: DateTime(2023),
            initialFocusDate: date,
            initialDateSelected: date,
            weekdayStart: DateTime.sunday,
            rangeMode: false,
            onDayTapped: (a) {
              date = a;
            });

        await Get.dialog(Dialog(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxHeight: 450, maxWidth: 400),
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
                        time.value = date;
                        widget.callback.call(date);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ));
        calendar.dispose();
      },
      child: Container(
        height: 53,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: time,
            builder: (context, snapshot) {
              return Visibility(
                visible: time.value == null,
                replacement: Text(Formatters.dateDisplay(time.value)),
                child: Text(widget.label),
              );
            },
          ),
        ),
      ),
    );
  }
}
