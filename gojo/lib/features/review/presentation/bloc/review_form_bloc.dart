import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gojo/features/review/data/models/review.dart';

import '../../data/repository/review_repository.dart';
import 'package:gojo/core/value_objects/message_input.dart';

part 'review_form_event.dart';
part 'review_form_state.dart';

const String successMessage = "Review Successfully submitted!";

class ReviewFormBloc extends Bloc<ReviewFormEvent, ReviewFormState> {
  final ReviewRepositoryAPI reviewRepository;

  ReviewFormBloc({required this.reviewRepository})
      : super(const ReviewFormState()) {
    on<ReviewFormMessageChanged>((event, emit) {
      final message = MessageInput.dirty(value: event.message);
      emit(
        state.copyWith(
          message: message,
          status: ReviewFormStatus.editing,
        ),
      );
    });

    on<ReviewFormRatingChanged>((event, emit) {
      emit(
        state.copyWith(
          rating: event.rating,
          status: ReviewFormStatus.editing,
        ),
      );
    });

    on<ReviewFormSubmissionInProgress>((event, emit) {
      emit(
        state.copyWith(
          status: ReviewFormStatus.inprogress,
        ),
      );
    });

    on<ReviewFormSubmitted>((event, emit) {
      ReviewModel review = ReviewModel(
        message: state.message.value,
        rating: state.rating,
      );
      emit(
        state.copyWith(
          status: ReviewFormStatus.inprogress,
        ),
      );
      try {
        reviewRepository.createReview(review);
        emit(
          state.copyWith(
            status: ReviewFormStatus.success,
            resultText: successMessage,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            status: ReviewFormStatus.error,
            resultText: e.toString(),
          ),
        );
      } finally {
        emit(
          state.copyWith(
            status: ReviewFormStatus.finished,
          ),
        );
      }
    });
  }
}
