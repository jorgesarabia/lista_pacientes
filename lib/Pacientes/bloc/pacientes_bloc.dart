import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:lista_pacientes/Pacientes/model/pacientes_model.dart';
import 'package:lista_pacientes/Pacientes/repository/pacientes_repository.dart';
import './bloc.dart';

class PacientesBloc extends Bloc<PacientesEvent, PacientesState> {
  final PacientesRepository _pacientesRepository = PacientesRepository();

  @override
  PacientesState get initialState => PacientesState.empty();

  @override
  Stream<PacientesState> mapEventToState(PacientesEvent event) async* {
    if (event is NombreChanged) {
      yield* _mapNombreChangedToState(event.nombre);
    } else if (event is CrearNuevoPaciente) {
      yield* _mapCrearPacienteToState(
        nombre: event.nombre,
        nroLibreta: event.nroLibreta,
      );
    }
  }

  Stream<PacientesState> _mapNombreChangedToState(String nombre) async* {
    yield state.update(
      isNameValid: nombre.isNotEmpty,
    );
  }

  Stream<PacientesState> _mapCrearPacienteToState({
    String nombre,
    String nroLibreta,
  }) async* {
    yield PacientesState.loading();
    try {
      await _pacientesRepository.updateOrCreate(PacientesModel(
        nombre: nombre,
        nroLibreta: nroLibreta,
      ));
      yield PacientesState.success();
    } catch (_) {
      yield PacientesState.failure();
    }
  }
}
