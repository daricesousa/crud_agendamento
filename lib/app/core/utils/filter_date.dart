import 'package:flutter/material.dart';

enum FilterDate {
  today,
  thisWeek,
  thisMonth,
  all;

  String get name {
    switch (this) {
      case FilterDate.today:
        return 'Hoje';
      case FilterDate.thisWeek:
        return 'Esta semana';
      case FilterDate.thisMonth:
        return 'Este mês';
      case FilterDate.all:
        return 'Todos';
      default:
        return '';
    }
  }

  DateTimeRange get range {
    final now = DateTime.now();
    switch (this) {
      case FilterDate.today:
        return DateTimeRange(start: now, end: now);
      case FilterDate.thisWeek:
        final weekday = now.weekday + 1;
        return DateTimeRange(
          start: now.subtract(Duration(days: weekday - 1)),
          end: now.add(Duration(days: 7 - weekday)),
        );
      case FilterDate.thisMonth:
        return DateTimeRange(
          start: DateTime(now.year, now.month),
          end: DateTime(now.year, now.month + 1)
              .subtract(const Duration(days: 1)),
        );
      case FilterDate.all:
        return DateTimeRange(
          start: DateTime(2000),
          end: now.add(const Duration(days: 365)),
        );
    }
  }
}
