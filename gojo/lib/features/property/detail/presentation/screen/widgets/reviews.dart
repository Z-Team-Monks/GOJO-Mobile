import 'package:flutter/material.dart';

import '../../../../review/data/models/review.dart';
import '../../../../review/presentation/screen/review_view.dart';
import 'review_card.dart';

class Reviews extends StatelessWidget {
  final List<Review> reviews;
  final int propertyId;

  const Reviews({
    super.key,
    required this.reviews,
    required this.propertyId,
  });

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
                    return ReviewForm(propertyId: propertyId);
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
