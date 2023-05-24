import 'package:flutter/material.dart';

import '../../../../../../Gojo-Mobile-Shared/UI/design_tokens/borders.dart';

class RatingIndicator extends StatelessWidget {
  final double rating;
  const RatingIndicator({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
          borderRadius: GojoBorders.border(GojoBorderRadiusSize.small),
          color: Colors.grey),
      child: Row(
        children: [
          const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          const SizedBox(width: 4),
          Text(
            rating.toString(),
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.white),
          )
        ],
      ),
    );
  }
}
