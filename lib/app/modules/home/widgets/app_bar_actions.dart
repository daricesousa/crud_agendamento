import 'package:crud_agendamento/app/core/utils/filter_status.dart';
import 'package:crud_agendamento/app/core/widgets/app_date_range.dart';
import 'package:crud_agendamento/app/core/widgets/app_form_field.dart';
import 'package:crud_agendamento/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarActions extends StatelessWidget {
  final HomeController controller;
  const AppBarActions({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Visibility(
              visible: !controller.showTextFilterField.value,
              replacement: SizedBox(
                width: 250.0,
                height: 45,
                child: AppFormField(
                  hintText: "Pesquisar",
                  onChanged: (v) => controller.textFilter.value = v,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close, size: 10),
                    onPressed: () {
                      controller.textFilter.value = '';
                      controller.showTextFilterField.value = false;
                    },
                  ),
                ),
              ),
              child: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => controller.showTextFilterField.value = true,
              ),
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
                icon: const Icon(Icons.calendar_month),
                onPressed: () {
                  Get.dialog(Obx(() => AppDateRange(
                        datesRange: controller.selectedDateRange.value,
                        callback: (datesRange) {
                          controller.dateFilterSelected.value = null;
                          controller.updateSelectedDateRange(datesRange);
                          controller.statusFilterSelected.assignAll(
                              [FilterStatus.past, FilterStatus.upcoming]);
                          Get.back();
                        },
                      )));
                })),
      ],
    );
  }
}
