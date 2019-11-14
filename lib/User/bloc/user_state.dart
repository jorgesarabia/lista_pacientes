import 'package:meta/meta.dart';

class UserState {
  final bool isNameValid;
  final bool isPassValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String password;

  bool isFormValid(String rePass){
    return (this.password == rePass) && isNameValid;
  }

  UserState({
    @required this.isNameValid,
    @required this.isPassValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    @required this.password,
  });

  factory UserState.empty() {
    return UserState(
      isNameValid: true,
      isPassValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      password: "",
    );
  }

  factory UserState.loading() {
    return UserState(
      isNameValid: true,
      isPassValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      password: "",
    );
  }

  factory UserState.failure() {
    return UserState(
      isNameValid: true,
      isPassValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      password: "",
    );
  }

  factory UserState.success() {
    return UserState(
      isNameValid: true,
      isPassValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      password: "",
    );
  }

  UserState update({
    bool isNameValid,
    bool isPassValid,
    String password,
  }) {
    return copyWith(
      isNameValid: isNameValid,
      isPassValid: isPassValid,
      password: password,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  UserState copyWith({
    bool isNameValid,
    bool isPassValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    String password,
  }) {
    return UserState(
      isNameValid: isNameValid ?? this.isNameValid,
      isPassValid: isPassValid ?? this.isPassValid,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}
