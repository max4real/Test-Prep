import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.titleKey, required this.title});
  final Key titleKey;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      key: titleKey,
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }
}
