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
  final now = DateTime.now();
  final formKey = GlobalKey<FormState>();
  final editName = TextEditingController();
  final editFone = TextEditingController();
  final editDate = ValueNotifier<DateTime?>(null);
  final editTime = ValueNotifier<TimeOfDay?>(null);
  final loading = ValueNotifier<bool>(false);
  final messageInvalidDate = ValueNotifier<String>("");

  @override
  void initState() {
    if (widget.appointmentEdit != null) loadAppointment();
    super.initState();
  }

  void loadAppointment() {
    final AppointmentModel appointment = widget.appointmentEdit!;
    editDate.value = appointment.date;
    editTime.value = TimeOfDay.fromDateTime(appointment.date);
    editName.text = appointment.name;
    editFone.text = appointment.fone ?? '';
  }

  bool isBeforeNow() {
    final date = DateTime(editDate.value!.year, editDate.value!.month,
        editDate.value!.day, editTime.value!.hour, editTime.value!.minute);
    if (date.isBefore(now)) {
      messageInvalidDate.value =
          "A data e a hora não podem ser anteriores a agora";
      return true;
    }
    messageInvalidDate.value = "";
    return false;
  }

  Future<void> saveAppointment() async {
    editDate.value ??= now;
    editTime.value ??=
        TimeOfDay.fromDateTime(now.add(const Duration(minutes: 1)));

    if (!loading.value && formKey.currentState!.validate() & !isBeforeNow()) {
      loading.value = true;
      final newAppointment = AppointmentModel(
        id: widget.appointmentEdit?.id ?? '',
        name: editName.text,
        fone: editFone.text,
        date: DateTime(editDate.value!.year, editDate.value!.month,
            editDate.value!.day, editTime.value!.hour, editTime.value!.minute),
      );
      await widget.callback.call(newAppointment);
      loading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  widget.title,
                  style: context.textTheme.headlineSmall,
                ),
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
                    child: AnimatedBuilder(
                        animation: editDate,
                        builder: (context, snapshot) {
                          return AppDate(
                            label: "Selecione a data",
                            initial: editDate.value,
                            callback: (date) {
                              Get.back();
                              editDate.value = date;
                            },
                          );
                        }),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 1,
                    child: AnimatedBuilder(
                        animation: editTime,
                        builder: (context, snapshot) {
                          return AppTime(
                            label: "Selecione a hora",
                            initial: editTime.value,
                            confirm: (time) => editTime.value = time,
                          );
                        }),
                  ),
                ],
              ),
              AnimatedBuilder(
                  animation: messageInvalidDate,
                  builder: (context, snapshot) {
                    return Visibility(
                      visible: messageInvalidDate.value.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Text(messageInvalidDate.value,
                            style: context.textTheme.bodySmall?.copyWith(
                                color: context.theme.colorScheme.error,
                                fontSize: 12)),
                      ),
                    );
                  }),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButton(
                    onPressed: () => Get.back(),
                    label: "Cancelar",
                  ),
                  const SizedBox(width: 10),
                  AppButton(onPressed: saveAppointment),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
