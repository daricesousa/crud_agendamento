import 'package:crud_agendamento/app/core/utils/formatters.dart';
import 'package:crud_agendamento/app/models/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardAppointment extends StatelessWidget {
  final AppointmentModel appointment;
  final Function()? edit;
  final Function()? delete;
  final bool actions;

  const CardAppointment({
    Key? key,
    required this.appointment,
    this.edit,
    this.delete,
    this.actions = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _IconText(icon: Icons.person, text: appointment.name),
                _IconText(
                    icon: Icons.calendar_month,
                    text:
                        "${(Formatters.dateDisplay(appointment.date))} às ${Formatters.hourDisplay(appointment.date)}"),
                if (appointment.fone != null)
                  _IconText(icon: Icons.phone, text: appointment.fone!),
              ],
            ),
            const Spacer(),
            if (actions)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!appointment.date.isBefore(DateTime.now()))
                    IconButton(
                        icon: Icon(Icons.edit,
                            color: context.theme.primaryColor.withAlpha(100)),
                        onPressed: edit),
                  IconButton(
                      icon: Icon(Icons.delete,
                          color: context.theme.primaryColor.withAlpha(100)),
                      onPressed: delete),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  const _IconText({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: context.theme.primaryColor.withAlpha(100),
        ),
        const SizedBox(width: 5),
        Text(text),
      ],
    );
  }
}
