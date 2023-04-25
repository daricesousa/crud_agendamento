import 'package:crud_agendamento/app/app_pages.dart';
import 'package:crud_agendamento/app/core/bindings/app_bindings.dart';
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
        getPages: AppPages.pages);
  }
}
