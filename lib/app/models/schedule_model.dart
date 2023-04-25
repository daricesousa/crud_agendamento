class ScheduleModel {
  final String id;
  final String name;
  final DateTime date;
  final String fone;

  ScheduleModel({
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

  factory ScheduleModel.fromMap(map) {
    return ScheduleModel(
      id: map['id'],
      name: map['name'] ?? '',
      date: DateTime.parse(map['date']),
      fone: map['fone'] ?? '',
    );
  }

  @override
  String toString() {
    return 'ScheduleModel(id: $id, name: $name, date: $date, fone: $fone)';
  }
}
