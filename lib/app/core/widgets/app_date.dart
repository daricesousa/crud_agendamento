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
  final dateConfirmed = ValueNotifier<DateTime?>(null);
  final now = DateTime.now();
  late DateTime dateSelected;

  @override
  void dispose() {
    dateConfirmed.dispose();
    super.dispose();
  }

  @override
  void initState() {
    dateConfirmed.value = widget.initial;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        dateSelected = widget.initial ?? now;
        final calendar = CleanCalendarController(
            maxDate: DateTime(DateTime.now().year, DateTime.now().month + 6,
                DateTime.now().day),
            minDate: DateTime(2023),
            initialFocusDate: dateSelected,
            initialDateSelected: dateSelected,
            weekdayStart: DateTime.sunday,
            rangeMode: false,
            onDayTapped: (a) {
              dateSelected = a;
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
                        dateConfirmed.value = dateSelected;
                        widget.callback.call(dateSelected);
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
            animation: dateConfirmed,
            builder: (context, snapshot) {
              return Visibility(
                visible: dateConfirmed.value == null,
                replacement: Text(Formatters.dateDisplay(dateConfirmed.value)),
                child: Text(widget.label),
              );
            },
          ),
        ),
      ),
    );
  }
}
