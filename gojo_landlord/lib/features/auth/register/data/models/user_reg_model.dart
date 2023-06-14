import 'package:equatable/equatable.dart';

class UserRegistrationModel extends Equatable {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String password;
  final String? profilePicture;
  final String identification;

  const UserRegistrationModel({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.password,
    required this.identification,
    this.profilePicture,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        phoneNumber,
        profilePicture,
        password,
        profilePicture,
        identification,
      ];
}
