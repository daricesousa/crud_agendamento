import 'package:crud_agendamento/app/core/http_clients/rest_client.dart';
import 'package:crud_agendamento/app/models/appointment_model.dart';
import 'package:crud_agendamento/app/repositories/appointment_repository.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final RestClient _restClient;

  AppointmentRepositoryImpl({
    required restClient,
  }) : _restClient = restClient;

  @override
  Future<List<AppointmentModel>> getAppointments() async {
    final result = await _restClient.get('/');
    return result.map<AppointmentModel>(AppointmentModel.fromMap).toList();
  }

  @override
  Future<AppointmentModel> postAppointment(AppointmentModel appointment) async {
    final result = await _restClient.post('/', data: appointment.toMap());
    return AppointmentModel.fromMap(result);
  }

  @override
  Future<AppointmentModel> putAppointment(AppointmentModel appointment) async {
    final result =
        await _restClient.put('/${appointment.id}', data: appointment.toMap());
    return AppointmentModel.fromMap(result);
  }

  @override
  Future<AppointmentModel> deleteAppointment(
      AppointmentModel appointment) async {
    final result = await _restClient.delete('/${appointment.id}');
    return AppointmentModel.fromMap(result);
  }
}
