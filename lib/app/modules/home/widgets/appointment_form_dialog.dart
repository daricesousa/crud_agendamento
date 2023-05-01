import 'package:crud_agendamento/app/core/widgets/app_button.dart';
import 'package:crud_agendamento/app/core/widgets/app_date.dart';
import 'package:crud_agendamento/app/core/widgets/app_form_field.dart';
import 'package:crud_agendamento/app/core/widgets/app_time.dart';
import 'package:crud_agendamento/app/models/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask/mask/mask.dart';

class AppointmentFormDialog extends StatefulWidget {
  final String title;
  final AppointmentModel? appointmentEdit;
  final Future<void> Function(AppointmentModel) callback;
  const AppointmentFormDialog({
    super.key,
    this.title = '',
    required this.callback,
    this.appointmentEdit,
  });

  @override
  State<AppointmentFormDialog> createState() => _AppointmentFormDialogState();
}

class _AppointmentFormDialogState extends State<AppointmentFormDialog> {
  final editName = TextEditingController();
  final editFone = TextEditingController();
  DateTime? editDate;
  TimeOfDay? editTime;

  @override
  void dispose() {
    editName.dispose();
    editFone.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.appointmentEdit != null) {
      loadAppointment();
    }
    super.initState();
  }

  void loadAppointment() {
    final AppointmentModel appointment = widget.appointmentEdit!;
    editDate = appointment.date;
    editTime = TimeOfDay.fromDateTime(appointment.date);
    editName.text = appointment.name;
    editFone.text = appointment.fone ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final loading = ValueNotifier<bool>(false);
    final formKey = GlobalKey<FormState>();

    return Dialog(
        child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                widget.title,
                style: context.textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              AppFormField(
                  label: "Nome",
                  controller: editName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Campo obrigatório";
                    }
                    return null;
                  }),
              const SizedBox(height: 10),
              AppFormField(
                label: "Telefone",
                textInputType: TextInputType.phone,
                inputFormatters: [Mask.phone()],
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    return Mask.validations.phone(value);
                  }
                  return null;
                },
                controller: editFone,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: AppDate(
                      label: "Selecione a data",
                      initial: editDate,
                      callback: (date) {
                        Get.back();
                        editDate = date;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 1,
                    child: AppTime(
                      label: "Selecione a hora",
                      initial: editTime,
                      confirm: (time) => editTime = time,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(
                    onPressed: () => Get.back(),
                    label: "Cancelar",
                  ),
                  const SizedBox(width: 10),
                  AnimatedBuilder(
                      animation: loading,
                      builder: (context, snapshot) {
                        return AppButton(
                          loading: loading.value,
                          onPressed: () async {
                            if (!loading.value &&
                                formKey.currentState!.validate()) {
                              loading.value = true;
                              editDate ??= DateTime.now();
                              editTime ??= TimeOfDay.now();
                              final newAppointment = AppointmentModel(
                                id: widget.appointmentEdit?.id ?? '',
                                name: editName.text,
                                fone: editFone.text,
                                date: DateTime(
                                    editDate!.year,
                                    editDate!.month,
                                    editDate!.day,
                                    editTime!.hour,
                                    editTime!.minute),
                              );
                              await widget.callback.call(newAppointment);
                              loading.value = false;
                            }
                          },
                        );
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
