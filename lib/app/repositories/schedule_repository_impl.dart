import 'package:crud_agendamento/app/core/http_clients/rest_client.dart';
import 'package:crud_agendamento/app/models/schedule_model.dart';
import 'package:crud_agendamento/app/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final RestClient _restClient;

  ScheduleRepositoryImpl({
    required restClient,
  }) : _restClient = restClient;

  @override
  Future<List<ScheduleModel>> getSchedules() async {
    final result = await _restClient.get('/');
    return result.map<ScheduleModel>(ScheduleModel.fromMap).toList();
  }
}
