part of 'register_bloc.dart';

enum RegisterFormStatus {
  editing,
  validAndConfirmed,
  inprogress,
  success,
  error,
}

class RegisterState extends Equatable {
  final PasswordInput password;
  final NameInput fname;
  final NameInput lname;
  final PhoneNumberInput phone;
  final String? idPath;
  final String? avatar;
  final bool consentConfirmed;
  final RegisterFormStatus formStatus;

  const RegisterState({
    this.password = const PasswordInput.pure(),
    this.fname = const NameInput.pure(),
    this.lname = const NameInput.pure(),
    this.phone = const PhoneNumberInput.pure(),
    this.idPath,
    this.avatar,
    this.consentConfirmed = false,
    this.formStatus = RegisterFormStatus.editing,
  });

  RegisterState copyWith({
    PasswordInput? password,
    NameInput? fname,
    NameInput? lname,
    PhoneNumberInput? phone,
    String? idPath,
    String? avatar,
    bool? consentConfirmed,
    RegisterFormStatus? formStatus,
  }) {
    return RegisterState(
      password: password ?? this.password,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      phone: phone ?? this.phone,
      idPath: idPath ?? this.idPath,
      avatar: avatar ?? this.avatar,
      consentConfirmed: consentConfirmed ?? this.consentConfirmed,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object?> get props => [
        password,
        fname,
        lname,
        phone,
        idPath,
        avatar,
        consentConfirmed,
        formStatus,
      ];

  bool get isPersonalInfoFormValid =>
      Formz.validate([password, fname, lname, phone]);
  bool get isIdCardSelected => isPersonalInfoFormValid & (idPath != null);
  bool get isRegisterFormValid =>
      isPersonalInfoFormValid & isIdCardSelected & consentConfirmed;
}
