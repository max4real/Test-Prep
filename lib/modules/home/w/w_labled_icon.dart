import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

class LabledIconWidget extends StatelessWidget {
  const LabledIconWidget(
      {super.key, required this.icon, required this.text, this.maxLines = 1});
  final IconData icon;
  final String text;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 15),
        const Gap(10),
        Expanded(
          child: Text(
            text,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
