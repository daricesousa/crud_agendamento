import 'package:flutter/material.dart';

class AppTime extends StatefulWidget {
  final String label;
  final TimeOfDay? initial;
  final void Function(TimeOfDay) confirm;
  const AppTime({
    super.key,
    this.label = "",
    required this.confirm,
    this.initial,
  });

  @override
  State<AppTime> createState() => _AppTimeState();
}

class _AppTimeState extends State<AppTime> {
  final time = ValueNotifier<TimeOfDay?>(null);

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

  String showTimer() {
    final hour = "${time.value?.hour}".padLeft(2, "0");
    final minute = "${time.value?.minute}".padLeft(2, "0");
    return "$hour:$minute";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final res = await showTimePicker(
            context: context,
            cancelText: "Cancelar",
            helpText: "Selecione o horário",
            minuteLabelText: "Minutos",
            hourLabelText: "Horas",
            initialTime: time.value ??
                TimeOfDay.fromDateTime(
                  DateTime(2022, 01, 01, 08, 00),
                ));
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
                replacement: Text(showTimer()),
                child: Text(widget.label),
              );
            },
          ),
        ),
      ),
    );
  }
}
