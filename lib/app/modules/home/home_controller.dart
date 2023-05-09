import 'package:crud_agendamento/app/core/utils/filter_date.dart';
import 'package:crud_agendamento/app/core/utils/filter_status.dart';
import 'package:crud_agendamento/app/core/utils/formatters.dart';
import 'package:crud_agendamento/app/core/widgets/app_snack_bar.dart';
import 'package:crud_agendamento/app/models/appointment_model.dart';
import 'package:crud_agendamento/app/repositories/appointment_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final AppointmentRepository _repository;
  final _appointments = <AppointmentModel>[].obs;
  late final selectedDateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now()).obs;
  String selectedDateRangeDisplay = '';
  final dateFilterSelected = Rx<FilterDate?>(FilterDate.thisMonth);
  final statusFilterSelected = <FilterStatus>[FilterStatus.upcoming].obs;

  HomeController({
    required AppointmentRepository repository,
  }) : _repository = repository;

  List<AppointmentModel> get appointments {
    List<AppointmentModel> newAppointments = List.from(_appointments);
    newAppointments = _filterByDateRange();
    newAppointments = _filterByStatus(newAppointments);
    newAppointments.sort((a, b) {
      return a.date.compareTo(b.date);
    });
    return newAppointments;
  }

  @override
  void onInit() {
    getAppointments();
    _initializeSelectedDateRange();
    updateSelectedDateRange(selectedDateRange.value);
    super.onInit();
  }

  void _initializeSelectedDateRange() {
    final start =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final end = DateTime(DateTime.now().year, DateTime.now().month + 1)
        .subtract(const Duration(days: 1));
    selectedDateRange.value = DateTimeRange(start: start, end: end);
  }

  void updateSelectedDateRange(DateTimeRange range) {
    selectedDateRange.value = range;
    final start = Formatters.dateDisplay(selectedDateRange.value.start);
    final end = Formatters.dateDisplay(selectedDateRange.value.end);
    selectedDateRangeDisplay = "$start - $end";
  }

  List<AppointmentModel> _filterByDateRange() {
    final start = DateTime(selectedDateRange.value.start.year,
        selectedDateRange.value.start.month, selectedDateRange.value.start.day);
    final end = DateTime(selectedDateRange.value.end.year,
            selectedDateRange.value.end.month, selectedDateRange.value.end.day)
        .add(const Duration(days: 1));
    return _appointments.where((e) {
      return e.date.isAfter(start) && (e.date.isBefore(end));
    }).toList();
  }

  List<AppointmentModel> _filterByStatus(List<AppointmentModel> appointments) {
    return appointments.where((a) {
      return statusFilterSelected.any((status) => status.isDateInRange(a.date));
    }).toList();
  }

  Future<void> getAppointments() async {
    final result = await _repository.getAppointments();
    _appointments.value = result;
  }

  Future<void> addAppointment(AppointmentModel appointment) async {
    try {
      final result = await _repository.postAppointment(appointment);
      _appointments.add(result);
      Get.back();
      AppSnackBar.success(message: 'Agendamento realizado');
    } catch (e) {
      AppSnackBar.error(message: 'Erro ao realizar agendamento');
    }
  }

  Future<void> editAppointment(AppointmentModel appointment) async {
    try {
      final index =
          _appointments.indexWhere((element) => element.id == appointment.id);
      _appointments[index] = await _repository.putAppointment(appointment);
      Get.back();
      AppSnackBar.success(message: 'Agendamento atualizado');
    } catch (e) {
      AppSnackBar.error(message: 'Erro ao atualizar agendamento');
    }
  }

  Future<void> deleteAppointment(AppointmentModel appointment) async {
    try {
      await _repository.deleteAppointment(appointment);
      _appointments.remove(appointment);
      Get.back();
      AppSnackBar.success(message: 'Agendamento deletado');
    } catch (e) {
      AppSnackBar.error(message: 'Erro ao deletar agendamento');
    }
  }
}
