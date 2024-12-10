import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key, required this.imageKey, required this.image});

  final Key imageKey;
  final String image;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      key: imageKey,
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        image,
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      ),
    );
  }
}
