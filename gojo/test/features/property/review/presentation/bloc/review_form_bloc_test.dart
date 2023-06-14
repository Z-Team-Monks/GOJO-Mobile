import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gojo/core/value_objects/message_input.dart';
import 'package:gojo/features/property/review/data/models/review.dart';
import 'package:gojo/features/property/review/data/repository/review_repository.dart';
import 'package:gojo/features/property/review/presentation/bloc/review_form_bloc.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'review_form_bloc_test.mocks.dart';

// Annotate the test file with @GenerateMocks
@GenerateMocks([ReviewRepositoryAPI])
void main() {
  late ReviewFormBloc reviewFormBloc;
  late MockReviewRepositoryAPI mockRepository;

  setUp(() {
    mockRepository = MockReviewRepositoryAPI();
    reviewFormBloc = ReviewFormBloc(
      reviewRepository: mockRepository,
      propertyId: 1,
    );
  });

  group('ReviewFormBloc', () {
    blocTest<ReviewFormBloc, ReviewFormState>(
      'emits ReviewFormMessageChanged state',
      build: () => reviewFormBloc,
      act: (bloc) => bloc.add(
        const ReviewFormMessageChanged(message: 'Test message'),
      ),
      expect: () => [
        const ReviewFormState(
          message: MessageInput.dirty(value: 'Test message'),
          rating: 2,
          status: ReviewFormStatus.editing,
          resultText: '',
        ),
      ],
    );

    blocTest<ReviewFormBloc, ReviewFormState>(
      'emits ReviewFormRatingChanged state',
      build: () => reviewFormBloc,
      act: (bloc) => bloc.add(
        const ReviewFormRatingChanged(rating: 5),
      ),
      expect: () => [
        const ReviewFormState(
          message: MessageInput.pure(),
          rating: 5,
          status: ReviewFormStatus.editing,
          resultText: '',
        ),
      ],
    );

    blocTest<ReviewFormBloc, ReviewFormState>(
      'emits ReviewFormStatus.success state',
      build: () => reviewFormBloc,
      skip: 1,
      act: (bloc) {
        bloc.add(
          const ReviewFormMessageChanged(message: 'Test message'),
        );
        when(
          mockRepository.createReview(
            review: const Review(
              comment: 'Test message',
              rating: 2,
            ),
            propertyId: 1,
          ),
        ).thenAnswer(
          (_) => Future.value(Review(
            comment: bloc.state.message.value,
            rating: bloc.state.rating,
          )),
        );
        bloc.add(ReviewFormSubmitted());
      },
      expect: () => const [
        ReviewFormState(
          message: MessageInput.dirty(value: 'Test message'),
          rating: 2,
          status: ReviewFormStatus.inprogress,
          resultText: '',
        ),
        ReviewFormState(
          message: MessageInput.dirty(value: 'Test message'),
          rating: 2,
          status: ReviewFormStatus.success,
          resultText: successMessage,
        ),
        ReviewFormState(
          message: MessageInput.dirty(value: 'Test message'),
          rating: 2,
          status: ReviewFormStatus.finished,
          resultText: successMessage,
        ),
      ],
    );
  });
}
