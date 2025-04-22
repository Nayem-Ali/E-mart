import 'package:flutter/material.dart';

class InfoChip extends StatelessWidget {
  final String label;
  final String value;

  const InfoChip({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withAlpha(90),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Text("$label: $value", style: Theme.of(context).textTheme.labelMedium,),
    );
  }
}
