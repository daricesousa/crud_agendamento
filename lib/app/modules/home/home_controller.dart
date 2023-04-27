import 'package:crud_agendamento/app/core/widgets/app_snack_bar.dart';
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

  Future<void> addAppointment(AppointmentModel appointment) async {
    try {
      final result = await _repository.postAppointment(appointment);
      appointments.add(result);
      Get.back();
      AppSnackBar.success(message: 'Agendamento realizado');
    } catch (e) {
      AppSnackBar.error(message: 'Erro ao realizar agendamento');
    }
  }

  Future<void> editAppointment(AppointmentModel appointment) async {
    try {
      final index =
          appointments.indexWhere((element) => element.id == appointment.id);
      appointments[index] = await _repository.putAppointment(appointment);
      Get.back();
      AppSnackBar.success(message: 'Agendamento atualizado');
    } catch (e) {
      AppSnackBar.error(message: 'Erro ao atualizar agendamento');
    }
  }

  Future<void> deleteAppointment(AppointmentModel appointment) async {
    try {
      await _repository.deleteAppointment(appointment);
      appointments.remove(appointment);
      Get.back();
      AppSnackBar.success(message: 'Agendamento deletado');
    } catch (e) {
      AppSnackBar.error(message: 'Erro ao deletar agendamento');
    }
  }
}
