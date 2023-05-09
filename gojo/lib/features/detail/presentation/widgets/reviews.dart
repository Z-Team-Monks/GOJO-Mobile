import 'package:flutter/material.dart';
import 'package:gojo/features/detail/presentation/widgets/review_card.dart';

import '../../../review/data/models/review.dart';
import '../../../review/presentation/review_view.dart';

class Reviews extends StatelessWidget {
  final List<Review> reviews;

  const Reviews({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text("Reviews"),
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
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: 1.5,
            width: 85,
            color: Colors.black,
          ),
        ),
        for (var review in reviews) ReviewCard(review: review),
      ],
    );
  }
}
