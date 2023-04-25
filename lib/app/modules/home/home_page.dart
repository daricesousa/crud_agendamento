import 'package:crud_agendamento/app/core/utils/formatters.dart';
import 'package:crud_agendamento/app/modules/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => ListView.builder(
        itemCount: controller.appointments.length,
        itemBuilder: (context, index) {
          final appointment = controller.appointments[index];
          return ListTile(
            title: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                Wrap(
                  children: [
                    const Icon(Icons.person),
                    Text(appointment.name),
                  ],
                ),
                Wrap(
                  children: [
                    const Icon(Icons.calendar_month),
                    Text(Formatters.dateDisplay(appointment.date)),
                  ],
                ),
                Wrap(
                  children: [
                    const Icon(Icons.timer),
                    Text(Formatters.hourDisplay(appointment.date)),
                  ],
                ),
                Visibility(
                  visible: appointment.fone.isNotEmpty,
                  child: Wrap(
                    children: [
                      const Icon(Icons.phone),
                      Text(Formatters.foneDisplay(appointment.fone)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ));
  }
}
