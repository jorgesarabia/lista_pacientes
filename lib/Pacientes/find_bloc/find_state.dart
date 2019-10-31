import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class FindState {
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  List<Widget> list;

  List<Widget> get getLista => list;

  FindState({
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    @required this.list,
  });

  factory FindState.loading() {
    return FindState(
      list: [],
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory FindState.failure() {
    return FindState(
      list: [],
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory FindState.success({
    List<Widget> list,
  }) {
    return FindState(
      list: list,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }
}
