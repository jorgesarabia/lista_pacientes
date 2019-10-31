import 'package:meta/meta.dart';

class PacientesState {
  final bool isNameValid;
  final bool isCiValid;
  final bool isNroLibretaValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isNameValid && isCiValid && isNroLibretaValid;

  PacientesState({
    @required this.isNameValid,
    @required this.isCiValid,
    @required this.isNroLibretaValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory PacientesState.empty() {
    return PacientesState(
      isNameValid: true,
      isCiValid: true,
      isNroLibretaValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory PacientesState.loading() {
    return PacientesState(
      isNameValid: true,
      isCiValid: true,
      isNroLibretaValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory PacientesState.failure() {
    return PacientesState(
      isNameValid: true,
      isCiValid: true,
      isNroLibretaValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory PacientesState.success() {
    return PacientesState(
      isNameValid: true,
      isCiValid: true,
      isNroLibretaValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  PacientesState update({
    bool isNameValid,
    bool isCiValid,
    bool isNroLibretaValid,
  }) {
    return copyWith(
      isNameValid: isNameValid,
      isCiValid: isCiValid,
      isNroLibretaValid: isNroLibretaValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  PacientesState copyWith({
    bool isNameValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isCiValid,
    bool isNroLibretaValid,
    bool isFailure,
  }) {
    return PacientesState(
      isNameValid: isNameValid ?? this.isNameValid,
      isCiValid: isCiValid ?? this.isCiValid,
      isNroLibretaValid: isNroLibretaValid ?? this.isNroLibretaValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}
