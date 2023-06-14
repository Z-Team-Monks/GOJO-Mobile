import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            Text(AppLocalizations.of(context)!.reviewes),
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
        ReviewsListView(reviews: reviews),
        // reviews.isEmpty ? Text(AppLocalizations.of(context)!.errorLoadingContent): for (var review in reviews) ReviewCard(review: review),
      ],
    );
  }
}

class ReviewsListView extends StatelessWidget {
  final List<Review> reviews;
  const ReviewsListView({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 70),
        child: Text("No reviewes yet!"),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: reviews.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: ((context, index) {
        return ReviewCard(review: reviews[index]);
      }),
    );
  }
}
