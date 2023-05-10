import 'package:crud_agendamento/app/core/widgets/app_snack_bar.dart';
import 'package:crud_agendamento/app/models/appointment_model.dart';
import 'package:crud_agendamento/app/modules/home/home_controller.dart';
import 'package:crud_agendamento/app/modules/home/widgets/app_bar_actions.dart';
import 'package:crud_agendamento/app/modules/home/widgets/appointment_delete_dialog.dart';
import 'package:crud_agendamento/app/modules/home/widgets/appointment_form_dialog.dart';
import 'package:crud_agendamento/app/modules/home/widgets/card_appointment.dart';
import 'package:crud_agendamento/app/modules/home/widgets/filter_appointments.dart';
import 'package:crud_agendamento/app/modules/home/widgets/no_appointments.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Agenda"),
          centerTitle: true,
          backgroundColor: context.theme.primaryColor.withAlpha(50),
          actions: [AppBarActions(controller: controller)],
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
              FilterAppointments(controller: controller),
              if (controller.loading.value)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                ),
              if (controller.appointments.isEmpty && !controller.loading.value)
                const NoAppointments(),
              if (controller.appointments.isNotEmpty)
                Expanded(child: LayoutBuilder(
                  builder: (context, constraints) {
                    return GridView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: controller.appointments.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: constraints.maxWidth ~/ 290,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 105,
                      ),
                      itemBuilder: (context, index) {
                        final appointment = controller.appointments[index];
                        return CardAppointment(
                            appointment: appointment,
                            edit: () {
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
                            delete: () {
                              showDialog<AppointmentModel>(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return AppointmentDeleteDialog(
                                      appointment: appointment,
                                      callback: () => controller
                                          .deleteAppointment(appointment),
                                    );
                                  });
                            });
                      },
                    );
                  },
                )),
            ],
          ),
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
