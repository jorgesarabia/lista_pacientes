import 'package:meta/meta.dart';

class UserState {
  final bool isNameValid;
  final bool isActualPassValid;
  final bool isNewPassValid;
  final bool isRetypeNewPassValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String password;
  final String errorMessage;

  UserState({
    @required this.isNameValid,
    @required this.isActualPassValid,
    @required this.isNewPassValid,
    @required this.isRetypeNewPassValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    @required this.password,
    @required this.errorMessage,
  });

  factory UserState.empty() {
    return UserState(
      isNameValid: true,
      isActualPassValid: true,
      isNewPassValid: true,
      isRetypeNewPassValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      password: "",
      errorMessage: "",
    );
  }

  factory UserState.loading() {
    return UserState(
      isNameValid: true,
      isActualPassValid: true,
      isNewPassValid: true,
      isRetypeNewPassValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      password: "",
      errorMessage: "",
    );
  }

  factory UserState.failure({
    String errorMessage,
    bool isActualPassValid,
  }) {
    return UserState(
      isNameValid: true,
      isActualPassValid: isActualPassValid ?? true,
      isNewPassValid: true,
      isRetypeNewPassValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      password: "",
      errorMessage: errorMessage,
    );
  }

  factory UserState.success() {
    return UserState(
      isNameValid: true,
      isActualPassValid: true,
      isNewPassValid: true,
      isRetypeNewPassValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      password: "",
      errorMessage: "",
    );
  }

  UserState update({
    bool isNameValid,
    bool isActualPassValid,
    bool isNewPassValid,
    bool isRetypeNewPassValid,
    String password,
    String errorMessage,
  }) {
    return copyWith(
      isNameValid: isNameValid,
      isActualPassValid: isActualPassValid,
      isNewPassValid: isNewPassValid,
      isRetypeNewPassValid: isRetypeNewPassValid,
      password: password,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      errorMessage: errorMessage,
    );
  }

  UserState copyWith({
    bool isNameValid,
    bool isActualPassValid,
    bool isNewPassValid,
    bool isRetypeNewPassValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    String password,
    String errorMessage,
  }) {
    return UserState(
      isNameValid: isNameValid ?? this.isNameValid,
      isActualPassValid: isActualPassValid ?? this.isActualPassValid,
      isNewPassValid: isNewPassValid ?? this.isNewPassValid,
      isRetypeNewPassValid: isRetypeNewPassValid ?? this.isRetypeNewPassValid,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
