import 'package:flutter/material.dart';

class PetDetailBox extends StatelessWidget {
  const PetDetailBox(
      {super.key,
      required this.value,
      required this.title,
      required this.color});
  final String value;
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.black,
                  ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.grey.shade800,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
