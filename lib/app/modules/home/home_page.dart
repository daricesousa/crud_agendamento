import 'package:crud_agendamento/app/core/utils/formatters.dart';
import 'package:crud_agendamento/app/core/widgets/app_snack_bar.dart';
import 'package:crud_agendamento/app/models/appointment_model.dart';
import 'package:crud_agendamento/app/modules/home/home_controller.dart';
import 'package:crud_agendamento/app/modules/home/widgets/appointment_form_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:responsive_row/responsive_row.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          () => ListView.builder(
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
                            text: Formatters.dateDisplay(appointment.date)),
                        itemCard(
                          icon: Icons.timer,
                          text: Formatters.hourDisplay(appointment.date),
                        ),
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
        lg: Sizes.col1,
        md: Sizes.col1,
        sm: Sizes.col1,
        child: Visibility(
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
