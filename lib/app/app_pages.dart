import 'package:crud_agendamento/app/modules/home/home_page.dart';
import 'package:crud_agendamento/app/modules/home/home_bindings.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();

  static final pages = <GetPage>[
    GetPage(
      name: '/',
      page: () => const HomePage(),
      binding: HomeBindings(),
    ),
  ];
}
