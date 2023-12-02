import 'package:flutter/material.dart';

class HourlyForcastitem extends StatelessWidget {
  final String time;
  final IconData? icon;
  final String value;

  const HourlyForcastitem({
    super.key,
    required this.time,
    this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Icon(
              icon,
              size: 30,
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
