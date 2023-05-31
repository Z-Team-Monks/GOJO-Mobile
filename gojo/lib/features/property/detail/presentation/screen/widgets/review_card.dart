import 'package:flutter/material.dart';

import '../../../../../review/data/models/review.dart';

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 25,
            child: Icon(
              Icons.person,
              color: Colors.white,
            ), // TODO: add user avatar
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 260,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${review.user.firstName} ${review.user.lastName}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      review.date,
                      style: const TextStyle(
                        color: Color(0xFFC5BDBD),
                        fontSize: 13,
                      ),
                    )
                  ],
                ),
                Row(children: [
                  for (var i = 0; i < review.rating; i++)
                    const Icon(
                      Icons.star,
                      size: 18,
                      color: Color(0xFFE67136),
                    ),
                ]),
                const SizedBox(height: 10),
                Text(
                  review.comment,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
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
