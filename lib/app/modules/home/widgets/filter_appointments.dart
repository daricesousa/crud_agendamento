import 'package:crud_agendamento/app/core/utils/filter_date.dart';
import 'package:crud_agendamento/app/core/utils/filter_status.dart';
import 'package:crud_agendamento/app/core/widgets/app_chip.dart';
import 'package:crud_agendamento/app/core/widgets/app_date_range.dart';
import 'package:crud_agendamento/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterAppointments extends StatelessWidget {
  final HomeController controller;
  const FilterAppointments({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      spacing: 40,
      children: [
        AppChip<FilterDate>(
          callback: (selectees) {
            controller.dateFilterSelected.value = selectees.first;
            controller.updateSelectedDateRange(selectees.first.range);
          },
          multiple: false,
          allowEmpty: false,
          values: FilterDate.values
              .map((e) => AppChipItem(label: e.name, value: e))
              .toList(),
          initial: controller.dateFilterSelected.value == null
              ? []
              : [controller.dateFilterSelected.value!],
        ),
        AppChip<FilterStatus>(
          allowEmpty: false,
          multiple: true,
          callback: (e) {
            controller.statusFilterSelected.assignAll(e);
          },
          values: FilterStatus.values
              .map((e) => AppChipItem(label: e.name, value: e))
              .toList(),
          initial: controller.statusFilterSelected,
        ),
        AppChip(
          allowEmpty: false,
          multiple: false,
          callback: (e) {
            Get.dialog(Obx(() => AppDateRange(
                  datesRange: controller.selectedDateRange.value,
                  callback: (datesRange) {
                    controller.selectRangeByCalendar(datesRange);
                    Get.back();
                  },
                )));
          },
          values: [
            AppChipItem(label: controller.selectedDateRangeDisplay, value: null)
          ],
          initial: const [null],
        ),
      ],
    );
  }
}
