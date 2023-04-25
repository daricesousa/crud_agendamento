import 'package:crud_agendamento/app/core/http_clients/rest_client.dart';
import 'package:crud_agendamento/app/repositories/schedule_repository.dart';
import 'package:crud_agendamento/app/repositories/schedule_repository_impl.dart';
import 'package:get/get.dart';
import './home_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScheduleRepository>(
        () => ScheduleRepositoryImpl(restClient: Get.find<RestClient>()));
    Get.lazyPut(
        () => HomeController(repository: Get.find<ScheduleRepository>()));
  }
}
