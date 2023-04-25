import 'package:crud_agendamento/app/models/schedule_model.dart';
import 'package:crud_agendamento/app/repositories/schedule_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ScheduleRepository _repository;
  final schedules = <ScheduleModel>[].obs;

  @override
  onReady() {
    getSchedules();
    super.onReady();
  }

  HomeController({
    required ScheduleRepository repository,
  }) : _repository = repository;

  Future<void> getSchedules() async {
    final result = await _repository.getSchedules();
    schedules.value = result;
  }
}
