import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final String rating;
  const Rating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, size: 20),
        const SizedBox(width: 5),
        Text(rating)
      ],
    );
  }
}
