import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/core/model/user.dart';
import 'package:gojo_landlord/Gojo-Mobile-Shared/core/repository/user_repository.dart';
import 'package:gojo_landlord/features/auth/signin/data_layer/repository/sign_in_repository.dart';
import 'package:gojo_landlord/features/auth/signin/presentation/bloc/sign_in_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'signin_bloc_test.mocks.dart';

@GenerateMocks([SignInRepositoryAPI, UserRepositoryAPI])
void main() {
  group('SignInBloc', () {
    late MockSignInRepositoryAPI signInRepository;
    late MockUserRepositoryAPI userRepository;
    late SignInBloc signInBloc;

    setUp(() {
      signInRepository = MockSignInRepositoryAPI();
      userRepository = MockUserRepositoryAPI();
      signInBloc = SignInBloc(
        signInRepository: signInRepository,
        userRepository: userRepository,
      );
    });

    const user = User(
      id: 1,
      firstName: 'John',
      lastName: 'Doe',
      phoneNumber: '1234567890',
      profilePicture: 'profile.jpg',
      token: 'token',
      displayProfilePicture: 'display.jpg',
    );

    blocTest<SignInBloc, SignInState>(
      'emits [loading, success] when authentication is successful',
      build: () {
        when(signInRepository.authenticate(
          phoneNumber: anyNamed('phoneNumber'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => const Left(user));

        when(userRepository.persistUser(user)).thenAnswer((_) async => true);

        return signInBloc;
      },
      act: (bloc) => bloc.add(Authenticate(
        phoneNumber: '1234567890',
        password: 'password',
      )),
      expect: () => [
        SignInState.initial().copyWith(
          status: SignInRequestStatus.loading,
          errorMessage: null,
        ),
        SignInState.initial().copyWith(
          status: SignInRequestStatus.success,
          errorMessage: null,
        ),
      ],
      verify: (_) {
        verify(signInRepository.authenticate(
          phoneNumber: '1234567890',
          password: 'password',
        )).called(1);

        verify(userRepository.persistUser(user)).called(1);
      },
    );

    // Add more test cases as needed
  });
}
