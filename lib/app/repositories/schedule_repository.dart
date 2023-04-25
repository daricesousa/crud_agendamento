import 'package:crud_agendamento/app/models/schedule_model.dart';

abstract class ScheduleRepository {
  Future<List<ScheduleModel>> getSchedules();
}
