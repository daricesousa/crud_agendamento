import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final int? maxLength;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  const AppFormField({
    Key? key,
    this.controller,
    this.label = "",
    this.maxLength,
    this.textInputType,
    this.inputFormatters,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLength: maxLength,
        autofocus: true,
        controller: controller,
        keyboardType: textInputType,
        textInputAction: TextInputAction.next,
        inputFormatters: inputFormatters,
        validator: validator,
        decoration: InputDecoration(
          label: Text(label),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ));
  }
}
