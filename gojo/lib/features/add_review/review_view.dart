import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../Gojo-Mobile-Shared/UI/input_fields/text_field.dart';
import '../../Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import '../../Gojo-Mobile-Shared/resources/resources.dart';

class AddReviewPopup extends StatelessWidget {
  const AddReviewPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Review",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 14),
              Text(
                "This review must be based on real experience of the House.",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 16),
              RatingBar.builder(
                initialRating: 2,
                minRating: 1,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Resources.gojoColors.primaryColor,
                ),
                onRatingUpdate: (rating) {},
              ),
              SizedBox(height: 16),
              GojoTextField(
                maxLines: 6,
              ),
              SizedBox(height: 24),
              GojoBarButton(title: "Submit", onClick: () {})
            ],
          ),
        ),
      ),
    );
  }
  // ,);
}
