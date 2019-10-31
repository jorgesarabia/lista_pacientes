import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:lista_pacientes/Pacientes/find_bloc/bloc.dart';
import 'package:lista_pacientes/Pacientes/repository/pacientes_repository.dart';

class FindBloc extends Bloc<FindEvent, FindState> {
  final PacientesRepository _pacientesRepository = PacientesRepository();
  @override
  FindState get initialState => FindState.loading();

  @override
  Stream<FindState> mapEventToState(FindEvent event) async* {
    if (event is QueryChanged) {
      yield* _mapBuscandoToState(event.query);
    }
  }

  Stream<FindState> _mapBuscandoToState(String query) async* {
    yield FindState.loading();
    try {
      print(query);
      List<Widget> lista = await _pacientesRepository.getPacientes(query);
      yield FindState.success(list: lista);
    } catch (_) {
      yield FindState.failure();
    }
  }
}
