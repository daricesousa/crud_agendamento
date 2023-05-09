enum FilterStatus {
  past,
  upcoming;

  String get name {
    switch (this) {
      case FilterStatus.past:
        return 'Histórico';
      case FilterStatus.upcoming:
        return 'Agendados';
      default:
        return '';
    }
  }

  bool isDateInRange(DateTime date) {
    switch (this) {
      case FilterStatus.past:
        return date.isBefore(DateTime.now());
      case FilterStatus.upcoming:
        return date.isAfter(DateTime.now());
      default:
        return false;
    }
  }
}
