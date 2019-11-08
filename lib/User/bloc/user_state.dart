import 'package:meta/meta.dart';

class UserState {
  final bool isNameValid;
  final bool isPassValid;
  final bool isRePassValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String password;

  bool get isFormValid => isNameValid && isPassValid;

  UserState({
    @required this.isNameValid,
    @required this.isPassValid,
    @required this.isRePassValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    @required this.password,
  });

  factory UserState.empty() {
    return UserState(
      isNameValid: true,
      isPassValid: true,
      isRePassValid: true,
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
      isRePassValid: true,
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
      isRePassValid: true,
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
      isRePassValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      password: "",
    );
  }

  UserState update({
    bool isNameValid,
    bool isPassValid,
    bool isRePassValid,
    String password,
  }) {
    return copyWith(
      isNameValid: isNameValid,
      isPassValid: isPassValid,
      isRePassValid: isRePassValid,
      password: password,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  UserState copyWith({
    bool isNameValid,
    bool isPassValid,
    bool isRePassValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    String password,
  }) {
    return UserState(
      isNameValid: isNameValid ?? this.isNameValid,
      isPassValid: isPassValid ?? this.isPassValid,
      isRePassValid: isRePassValid ?? this.isRePassValid,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}
