import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final Color? color;
  final Color? colorLabel;
  final double? height;
  final bool loading;
  final Function() onPressed;

  const AppButton(
      {Key? key,
      this.label = "Salvar",
      required this.onPressed,
      this.color,
      this.colorLabel,
      this.height,
      this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18)))),
        child: Visibility(
          visible: !loading,
          replacement: const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
              )),
          child: Text(
            label,
            style: TextStyle(color: colorLabel),
          ),
        ),
      ),
    );
  }
}
