import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../Gojo-Mobile-Shared/UI/input_fields/text_field.dart';
import '../../../../../Gojo-Mobile-Shared/UI/snack_bars/snackbars.dart';
import '../../../../../Gojo-Mobile-Shared/UI/widgets/bar_button.dart';
import '../../data/repository/review_repository.dart';
import '../bloc/review_form_bloc.dart';
import 'widgets/gojo_rating_bar.dart';

class ReviewForm extends StatelessWidget {
  final int propertyId;
  const ReviewForm({super.key, required this.propertyId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReviewFormBloc(
        propertyId: propertyId,
        reviewRepository: GetIt.I<ReviewRepositoryAPI>(),
      ),
      child: const AddReviewPopup(),
    );
  }
}

class AddReviewPopup extends StatelessWidget {
  const AddReviewPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReviewFormBloc, ReviewFormState>(
      listener: (context, state) {
        switch (state.status) {
          case ReviewFormStatus.success:
            GojoSnackBars.showSuccess(context, state.resultText);
            break;
          case ReviewFormStatus.error:
            GojoSnackBars.showError(context, state.resultText);
            break;
          case ReviewFormStatus.finished:
            Navigator.of(context).pop();
            break;
          default:
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Add Review",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    "This review must be based on real experience of the House.",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GojoRatingBar(
                    onRatingUpdate: (rating) {
                      BlocProvider.of<ReviewFormBloc>(context).add(
                        ReviewFormRatingChanged(rating: rating),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<ReviewFormBloc, ReviewFormState>(
                    builder: (context, state) {
                      return GojoTextField(
                        hintText: "Write your review here.",
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {
                          BlocProvider.of<ReviewFormBloc>(context).add(
                            ReviewFormMessageChanged(message: value),
                          );
                        },
                        errorText:
                            !state.message.isPure && state.message.isNotValid
                                ? state.message.getErrorMessage()
                                : null,
                        maxLines: 6,
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<ReviewFormBloc, ReviewFormState>(
                      builder: (context, state) {
                    return GojoBarButton(
                      title: "Submit",
                      isActive: state.isFormValid,
                      loadingState: state.status == ReviewFormStatus.inprogress,
                      onClick: () {
                        BlocProvider.of<ReviewFormBloc>(context).add(
                          ReviewFormSubmitted(),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
