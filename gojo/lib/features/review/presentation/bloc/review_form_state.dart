part of 'review_form_bloc.dart';

enum ReviewFormStatus { editing, inprogress, success, error, finished }

class ReviewFormState extends Equatable {
  const ReviewFormState({
    this.message = const MessageInput.pure(),
    this.rating = 2,
    this.status = ReviewFormStatus.editing,
    this.resultText = "",
  });

  ReviewFormState copyWith({
    MessageInput? message,
    num? rating,
    ReviewFormStatus? status,
    String? resultText,
  }) {
    return ReviewFormState(
      message: message ?? this.message,
      rating: rating ?? this.rating,
      status: status ?? this.status,
      resultText: resultText ?? this.resultText,
    );
  }

  final MessageInput message;
  final num rating;
  final ReviewFormStatus status;
  final String resultText;

  @override
  List<Object> get props => [message, rating, status];
}
