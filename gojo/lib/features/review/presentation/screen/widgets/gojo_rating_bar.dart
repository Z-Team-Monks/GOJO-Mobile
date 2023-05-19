import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '/../../Gojo-Mobile-Shared/resources/resources.dart';

class GojoRatingBar extends StatelessWidget {
  final void Function(double) onRatingUpdate;

  const GojoRatingBar({
    super.key,
    required this.onRatingUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      glowColor: Colors.greenAccent,
      glowRadius: 1,
      initialRating: 2,
      minRating: 0,
      itemCount: 5,
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Resources.gojoColors.primaryColor,
      ),
      onRatingUpdate: onRatingUpdate,
    );
  }
}
