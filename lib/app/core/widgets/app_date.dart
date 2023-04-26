import 'package:crud_agendamento/app/core/utils/formatters.dart';
import 'package:flutter/material.dart';

class AppDate extends StatefulWidget {
  final String label;
  final DateTime? initial;
  final void Function(DateTime) confirm;
  const AppDate({
    super.key,
    required this.confirm,
    this.label = "",
    this.initial,
  });

  @override
  State<AppDate> createState() => _AppDateState();
}

class _AppDateState extends State<AppDate> {
  final time = ValueNotifier<DateTime?>(null);
  final now = DateTime.now();

  @override
  void dispose() {
    time.dispose();
    super.dispose();
  }

  @override
  void initState() {
    time.value = widget.initial;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final res = await showDatePicker(
            context: context,
            cancelText: "Cancelar",
            helpText: "Selecione a data",
            firstDate: now,
            initialDate: time.value ?? now,
            lastDate: DateTime(now.year, now.month + 3, now.day));
        if (res != null) {
          time.value = res;
          widget.confirm(res);
        }
      },
      child: Container(
        height: 53,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: time,
            builder: (context, snapshot) {
              return Visibility(
                visible: time.value == null,
                replacement: Text(Formatters.dateDisplay(time.value)),
                child: Text(widget.label),
              );
            },
          ),
        ),
      ),
    );
  }
}
