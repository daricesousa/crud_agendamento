import 'package:crud_agendamento/app/core/widgets/app_button.dart';
import 'package:crud_agendamento/app/models/appointment_model.dart';
import 'package:crud_agendamento/app/modules/home/widgets/card_appointment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentDeleteDialog extends StatefulWidget {
  final AppointmentModel appointment;
  final Future<void> Function() callback;
  const AppointmentDeleteDialog({
    super.key,
    required this.appointment,
    required this.callback,
  });

  @override
  State<AppointmentDeleteDialog> createState() =>
      _AppointmentDeleteDialogState();
}

class _AppointmentDeleteDialogState extends State<AppointmentDeleteDialog> {
  @override
  Widget build(BuildContext context) {
    final loading = ValueNotifier<bool>(false);
    final appointment = widget.appointment;
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Deletar agendamento",
                  style: context.theme.textTheme.headlineSmall),
              const SizedBox(height: 20),
              const Text("Tem certeza que deseja deletar esse agendamento?"),
              const SizedBox(height: 10),
              CardAppointment(appointment: appointment, actions: false),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 20,
                runSpacing: 10,
                children: [
                  AppButton(label: "Cancelar", onPressed: Get.back),
                  AnimatedBuilder(
                      animation: loading,
                      builder: (context, snapshot) {
                        return AppButton(
                            loading: loading.value,
                            label: "Confirmar",
                            onPressed: () async {
                              if (!loading.value) {
                                loading.value = true;
                                await widget.callback.call();
                                loading.value = false;
                              }
                            });
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
