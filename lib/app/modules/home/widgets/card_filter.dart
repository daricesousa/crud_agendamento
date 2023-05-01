import 'package:flutter/material.dart';

class CardFilter extends StatelessWidget {
  final Widget child;
  final void Function() action;

  const CardFilter({Key? key, required this.child, required this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          padding: const EdgeInsets.all(5),
          child: ElevatedButton(onPressed: action, child: child),
        ));
  }
}
