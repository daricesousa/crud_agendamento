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
        itemCount: controller.schedules.length,
        itemBuilder: (context, index) {
          final schedule = controller.schedules[index];
          return ListTile(
            title: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                Wrap(
                  children: [
                    const Icon(Icons.person),
                    Text(schedule.name),
                  ],
                ),
                Wrap(
                  children: [
                    const Icon(Icons.calendar_month),
                    Text(Formatters.dateDisplay(schedule.date)),
                  ],
                ),
                Wrap(
                  children: [
                    const Icon(Icons.timer),
                    Text(Formatters.hourDisplay(schedule.date)),
                  ],
                ),
                Visibility(
                  visible: schedule.fone.isNotEmpty,
                  child: Wrap(
                    children: [
                      const Icon(Icons.phone),
                      Text(Formatters.foneDisplay(schedule.fone)),
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
