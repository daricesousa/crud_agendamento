import 'package:crud_agendamento/app/models/appointment_model.dart';
import 'package:crud_agendamento/app/repositories/appointment_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final AppointmentRepository _repository;
  final appointments = <AppointmentModel>[].obs;

  @override
  onReady() {
    getAppointments();
    super.onReady();
  }

  HomeController({
    required AppointmentRepository repository,
  }) : _repository = repository;

  Future<void> getAppointments() async {
    final result = await _repository.getAppointments();
    appointments.value = result;
  }
}
