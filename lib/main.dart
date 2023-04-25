import 'package:crud_agendamento/app/core/bindings/app_bindings.dart';
import 'package:crud_agendamento/app/core/http_clients/rest_client.dart';
import 'package:crud_agendamento/app/repositories/schedule_repository.dart';
import 'package:crud_agendamento/app/repositories/schedule_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CRUD agendamento',
      initialBinding: AppBindings(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScheduleRepository repository =
      ScheduleRepositoryImpl(restClient: Get.find<RestClient>());
  @override
  void initState() {
    repository.getSchedules().then((res) => print(res));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
