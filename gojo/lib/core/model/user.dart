import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final String phoneNumber;
  @HiveField(4)
  final String profilePicture;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone'],
      profilePicture: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "profilePicture": profilePicture,
    };
  }

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        phoneNumber,
        profilePicture,
      ];
}
