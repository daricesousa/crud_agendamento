import 'package:crud_agendamento/app/models/appointment_model.dart';

abstract class AppointmentRepository {
  Future<List<AppointmentModel>> getAppointments();

  Future<AppointmentModel> postAppointment(AppointmentModel appointment);

  Future<AppointmentModel> putAppointment(AppointmentModel appointment);

  Future<AppointmentModel> deleteAppointment(AppointmentModel appointment);
}
