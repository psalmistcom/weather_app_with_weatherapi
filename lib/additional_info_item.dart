import 'package:flutter/material.dart';

class AddtionalInfoItem extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String value;
  const AddtionalInfoItem({
    super.key,
    this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        const SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
