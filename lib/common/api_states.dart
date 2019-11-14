import 'package:meta/meta.dart';

class ApiStates {
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  ApiStates({
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory ApiStates.empty() {
    return ApiStates(
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory ApiStates.loading() {
    return ApiStates(
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory ApiStates.failure() {
    return ApiStates(
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory ApiStates.success() {
    return ApiStates(
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

}