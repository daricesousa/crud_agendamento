import 'package:crud_agendamento/app/core/utils/validations.dart';

class AppointmentModel {
  final String id;
  final String name;
  final DateTime date;
  final String fone;

  AppointmentModel({
    this.id = '',
    required this.name,
    required this.date,
    this.fone = '',
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'date': date.millisecondsSinceEpoch,
      'fone': fone,
    };
  }

  factory AppointmentModel.fromMap(map) {
    return AppointmentModel(
      id: map['id'],
      name: map['name'] ?? '',
      date: DateTime.parse(map['date']),
      fone: Validations.foneIsValid(map['fone']) ? map['fone'] : '',
    );
  }

  @override
  String toString() {
    return 'AppointmentModel(id: $id, name: $name, date: $date, fone: $fone)';
  }
}
