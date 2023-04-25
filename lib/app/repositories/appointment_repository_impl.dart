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
}
