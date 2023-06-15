import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gojo_landlord/features/auth/register/data/models/user_reg_model.dart';
import 'package:gojo_landlord/features/auth/register/data/repository/register_repository.dart';
import 'package:gojo_landlord/features/auth/register/presentation/bloc/register_bloc.dart';
import 'package:gojo_landlord/features/auth/register/presentation/value_objects/name_input.dart';
import 'package:gojo_landlord/features/auth/signin/presentation/model/password_input.dart';
import 'package:gojo_landlord/features/auth/signin/presentation/model/phone_number_input.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_bloc_test.mocks.dart';

@GenerateMocks([RegisterRepository])
void main() {
  late RegisterBloc registerBloc;
  late MockRegisterRepository mockRegisterRepository;

  setUp(() {
    mockRegisterRepository = MockRegisterRepository();
    registerBloc = RegisterBloc(registerRepository: mockRegisterRepository);
  });

  tearDown(() {
    registerBloc.close();
  });

  group('RegisterBloc', () {
    test('initial state should be correct', () {
      expect(registerBloc.state, const RegisterState());
    });

    blocTest<RegisterBloc, RegisterState>(
      'emits correct states when FirstNameChanged event is added',
      build: () => registerBloc,
      act: (bloc) => bloc.add(FirstNameChanged(fname: 'John')),
      expect: () => [
        const RegisterState(fname: NameInput.dirty(value: 'John')),
      ],
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits correct states when LastNameChanged event is added',
      build: () => registerBloc,
      act: (bloc) => bloc.add(LastNameChanged(lname: 'Doe')),
      expect: () => [
        const RegisterState(lname: NameInput.dirty(value: 'Doe')),
      ],
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits correct states when PasswordChanged event is added',
      build: () => registerBloc,
      act: (bloc) => bloc.add(PasswordChanged(password: 'password123')),
      expect: () => [
        const RegisterState(
          password: PasswordInput.dirty(value: 'password123'),
        ),
      ],
    );

    // Add more test cases for other events and state transitions

    blocTest<RegisterBloc, RegisterState>(
      'emits correct states when ConfirmedAndSubmitted event is added',
      build: () => registerBloc,
      act: (bloc) {
        bloc.add(FirstNameChanged(fname: 'John'));
        bloc.add(LastNameChanged(lname: 'Doe'));
        bloc.add(PhoneChanged(phone: '1234567890'));
        bloc.add(PasswordChanged(password: 'password123'));
        bloc.add(IDFileChanged(path: 'path/to/identification'));
        bloc.add(AvatarChanged(path: ''));
        bloc.add(ConfirmedAndSubmitted());
      },
      skip: 6,
      verify: (_) {
        const user = UserRegistrationModel(
          firstName: 'John',
          lastName: 'Doe',
          phoneNumber: '1234567890',
          password: 'password123',
          identification: 'path/to/identification',
          profilePicture: '',
        );

        verify(mockRegisterRepository.registerUser(user: user)).called(1);
      },
      expect: () => [
        const RegisterState(
          formStatus: RegisterFormStatus.inprogress,
          fname: NameInput.dirty(value: 'John'),
          lname: NameInput.dirty(value: 'Doe'),
          phone: PhoneNumberInput.dirty(value: '1234567890'),
          password: PasswordInput.dirty(value: 'password123'),
          idPath: 'path/to/identification',
          avatar: '',
        ),
        const RegisterState(
          formStatus: RegisterFormStatus.success,
          fname: NameInput.dirty(value: 'John'),
          lname: NameInput.dirty(value: 'Doe'),
          phone: PhoneNumberInput.dirty(value: '1234567890'),
          password: PasswordInput.dirty(value: 'password123'),
          idPath: 'path/to/identification',
          avatar: '',
        ),
      ],
    );
  });
}
