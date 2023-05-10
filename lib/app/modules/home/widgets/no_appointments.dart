import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoAppointments extends StatelessWidget {
  const NoAppointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(
        Icons.note,
        size: 50,
        color: context.theme.primaryColor.withAlpha(100),
      ),
      Text(
        'Sem registros',
        style: context.textTheme.titleMedium,
      ),
    ]));
  }
}
