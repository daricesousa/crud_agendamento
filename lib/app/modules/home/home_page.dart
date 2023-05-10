import 'package:crud_agendamento/app/core/utils/filter_date.dart';
import 'package:crud_agendamento/app/core/utils/filter_status.dart';
import 'package:crud_agendamento/app/core/utils/formatters.dart';
import 'package:crud_agendamento/app/core/widgets/app_chip.dart';
import 'package:crud_agendamento/app/core/widgets/app_date_range.dart';
import 'package:crud_agendamento/app/core/widgets/app_snack_bar.dart';
import 'package:crud_agendamento/app/models/appointment_model.dart';
import 'package:crud_agendamento/app/modules/home/home_controller.dart';
import 'package:crud_agendamento/app/modules/home/widgets/appointment_delete_dialog.dart';
import 'package:crud_agendamento/app/modules/home/widgets/appointment_form_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:responsive_row/responsive_row.dart';

import '../../core/widgets/app_form_field.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Agenda"),
          centerTitle: true,
          backgroundColor: context.theme.primaryColor.withAlpha(50),
          actions: [
            Row(
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
                        onPressed: () =>
                            controller.showTextFilterField.value = true,
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
                                  controller
                                      .updateSelectedDateRange(datesRange);
                                  controller.statusFilterSelected.assignAll([
                                    FilterStatus.past,
                                    FilterStatus.upcoming
                                  ]);
                                  Get.back();
                                },
                              )));
                        })),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              openDialog(
                context: context,
                title: "Novo agendamento",
                callback: controller.addAppointment,
              );
            }),
        body: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
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
                  AppChip<void>(
                    allowEmpty: false,
                    multiple: false,
                    callback: (e) {},
                    values: [
                      AppChipItem(
                          label: controller.selectedDateRangeDisplay,
                          value: null)
                    ],
                    initial: const [null],
                  ),
                ],
              ),
              if (controller.loading.value)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                ),
              if (controller.appointments.isEmpty && !controller.loading.value)
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Icon(
                        Icons.note,
                        size: 50,
                        color: context.theme.primaryColor,
                      ),
                      const Text('Sem registros'),
                    ])),
              if (controller.appointments.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.appointments.length,
                    itemBuilder: (context, index) {
                      final appointment = controller.appointments[index];
                      return ResponsiveCol(
                        child: Card(
                          child: ListTile(
                            title: ResponsiveRow(
                              alignment: WrapAlignment.spaceBetween,
                              children: [
                                itemCard(
                                    icon: Icons.person,
                                    text: appointment.name,
                                    sizes: Sizes.col3),
                                itemCard(
                                    icon: Icons.calendar_month,
                                    text: Formatters.dateDisplay(
                                        appointment.date)),
                                itemCard(
                                    icon: Icons.timer,
                                    text: Formatters.hourDisplay(
                                        appointment.date),
                                    sizes: Sizes.col1),
                                itemCard(
                                    icon: Icons.phone,
                                    text: appointment.fone ?? '',
                                    visible: appointment.fone != null,
                                    sizes: Sizes.col3),
                                actionsCard(
                                  context: context,
                                  appointment: appointment,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ));
  }

  ResponsiveCol itemCard(
      {IconData? icon,
      String text = '',
      bool visible = true,
      Sizes sizes = Sizes.col2}) {
    return ResponsiveCol(
      lg: sizes,
      md: sizes,
      sm: Sizes.col12,
      child: Visibility(
        visible: visible,
        child: Row(
          children: [
            Icon(icon),
            Text(text),
          ],
        ),
      ),
    );
  }

  ResponsiveCol actionsCard(
      {required BuildContext context, required AppointmentModel appointment}) {
    return ResponsiveCol(
        lg: Sizes.col2,
        md: Sizes.col2,
        sm: Sizes.col12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: appointment.date.isAfter(DateTime.now()),
              child: IconButton(
                  onPressed: () {
                    if (appointment.date.isBefore(DateTime.now())) {
                      AppSnackBar.error(
                          message:
                              "Não é possível editar um agendamento que já passou");
                    } else {
                      openDialog(
                        context: context,
                        callback: controller.editAppointment,
                        appointmentEdit: appointment,
                        title: "Editar agendamento",
                      );
                    }
                  },
                  icon: const Icon(Icons.edit_document)),
            ),
            IconButton(
                onPressed: () async {
                  await showDialog<AppointmentModel>(
                      context: context,
                      builder: (context) {
                        return AppointmentDeleteDialog(
                          appointment: appointment,
                          callback: () async {
                            await controller.deleteAppointment(appointment);
                          },
                        );
                      });
                },
                icon: const Icon(Icons.delete)),
          ],
        ));
  }

  Future<AppointmentModel?> openDialog(
      {required BuildContext context,
      AppointmentModel? appointmentEdit,
      required Future<void> Function(AppointmentModel) callback,
      String title = ''}) async {
    return await showDialog<AppointmentModel>(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AppointmentFormDialog(
            title: title,
            callback: callback,
            appointmentEdit: appointmentEdit,
          );
        });
  }
}
