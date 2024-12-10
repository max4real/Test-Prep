import 'package:flutter/material.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget(
      {super.key, required this.descriptionKey, required this.description});
  final Key descriptionKey;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        description,
        style: const TextStyle(fontSize: 16, color: Colors.grey),
        textAlign: TextAlign.center,
      ),
    );
  }
}
