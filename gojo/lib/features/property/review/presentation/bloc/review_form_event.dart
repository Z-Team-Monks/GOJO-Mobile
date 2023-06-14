part of 'review_form_bloc.dart';

abstract class ReviewFormEvent extends Equatable {
  const ReviewFormEvent();
}

class ReviewFormMessageChanged extends ReviewFormEvent {
  final String message;
  const ReviewFormMessageChanged({required this.message});

  @override
  List<Object> get props => [message];
}

class ReviewFormRatingChanged extends ReviewFormEvent {
  final num rating;
  const ReviewFormRatingChanged({required this.rating});

  @override
  List<Object> get props => [rating];
}

class ReviewFormSubmissionInProgress extends ReviewFormEvent {
  @override
  List<Object> get props => [];
}

class ReviewFormSubmitted extends ReviewFormEvent {
  @override
  List<Object> get props => [];
}
