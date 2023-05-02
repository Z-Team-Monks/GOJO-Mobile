import 'package:flutter/material.dart';

import '../../../review/data/models/review.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  const ReviewCard({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 25,
                child: Icon(Icons.person_off_outlined), // TODO: add user avatar
              ),
              const SizedBox(width: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${review.user.firstName} ${review.user.lastName}",
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              review.comment,
            ),
          ),
          const SizedBox(height: 10),
          const HorizontalUnderline(color: Colors.grey),
        ],
      ),
    );
  }
}

class HorizontalUnderline extends StatelessWidget {
  final Color color;
  const HorizontalUnderline({
    super.key,
    this.color = Colors.redAccent,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 18.0),
      child: Container(
        height: 1,
        color: color,
      ),
    );
  }
}
