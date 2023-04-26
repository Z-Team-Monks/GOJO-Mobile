import 'package:flutter/material.dart';

import '../../../../review/presentation/review_view.dart';
import '../review_card.dart';

class TabReviews extends StatelessWidget {
  const TabReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const ReviewCard(),
          const ReviewCard(),
          const ReviewCard(),
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
