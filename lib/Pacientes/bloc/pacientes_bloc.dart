import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PacientesBloc extends Bloc<PacientesEvent, PacientesState> {
  @override
  PacientesState get initialState => InitialPacientesState();

  @override
  Stream<PacientesState> mapEventToState(
    PacientesEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
