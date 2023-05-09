import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppChip<T> extends StatefulWidget {
  final void Function(List<T>) callback;
  final List<AppChipItem<T>> values;
  final List<T> initial;
  final bool multiple;
  final bool updateSelectionOnInitialChange;
  final bool allowEmpty;

  const AppChip({
    Key? key,
    required this.callback,
    required this.values,
    required this.initial,
    this.multiple = true,
    this.updateSelectionOnInitialChange = true,
    this.allowEmpty = true,
  }) : super(key: key);

  @override
  State<AppChip<T>> createState() => _AppChipState<T>();
}

class _AppChipState<T> extends State<AppChip<T>> {
  final selectees = <T>[];

  @override
  void initState() {
    selectees.assignAll(widget.initial);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AppChip<T> oldWidget) {
    if (widget.updateSelectionOnInitialChange) {
      selectees.assignAll(widget.initial);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _toggleSelect(AppChipItem<T> item) {
    if (selectees.contains(item.value)) {
      if ((selectees.length > 1 && !widget.allowEmpty) || widget.allowEmpty) {
        selectees.remove(item.value);
      }
    } else {
      if (widget.multiple) {
        selectees.add(item.value);
      } else {
        selectees.assignAll([item.value]);
      }
    }
    setState(() {
      widget.callback.call(selectees);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 6, vertical: context.heightTransformer(reducedBy: 98)),
      child: Wrap(
        children: widget.values.map((item) {
          return InkWell(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: context.theme.primaryColor),
                  borderRadius: BorderRadius.circular(50),
                  color: selectees.contains(item.value)
                      ? context.theme.primaryColor.withOpacity(0.3)
                      : Colors.white,
                ),
                child: Text(
                  item.label,
                  style: context.textTheme.titleSmall,
                ),
              ),
              onTap: () => _toggleSelect(item));
        }).toList(),
      ),
    );
  }
}

class AppChipItem<T> {
  final String label;
  final T value;

  const AppChipItem({required this.label, required this.value});
}
