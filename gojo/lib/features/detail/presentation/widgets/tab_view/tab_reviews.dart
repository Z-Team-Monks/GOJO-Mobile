import 'package:flutter/material.dart';

import '../../../../review/data/models/review.dart';
import '../../../../review/presentation/review_view.dart';
import '../review_card.dart';

class TabReviews extends StatelessWidget {
  final List<Review> reviews;
  const TabReviews({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var review in reviews) ReviewCard(review: review),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const ReviewForm();
                },
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
