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
    } else if (event is CIChanged) {
      yield* _mapCiChangedToState(event.ci);
    } else if (event is NroLibretaChanged) {
      yield* _mapNroLibretaChangedToState(event.nroLibreta);
    } else if (event is CreateOrUpdatePaciente) {
      yield* _mapCrearPacienteToState(
        id: event.id,
        nombre: event.nombre,
        nroLibreta: event.nroLibreta,
        ci: event.ci,
      );
    }
  }

  Stream<PacientesState> _mapNombreChangedToState(String nombre) async* {
    yield state.update(
      isNameValid: nombre.isNotEmpty,
    );
  }

  Stream<PacientesState> _mapCiChangedToState(String ci) async* {
    yield state.update(
      isCiValid: ci.isNotEmpty,
    );
  }

  Stream<PacientesState> _mapNroLibretaChangedToState(
      String nroLibreta) async* {
    yield state.update(
      isNroLibretaValid: nroLibreta.isNotEmpty,
    );
  }

  Stream<PacientesState> _mapCrearPacienteToState({
    String nombre,
    String nroLibreta,
    String ci,
    String id,
  }) async* {
    yield PacientesState.loading();
    try {
      await _pacientesRepository.updateOrCreate(PacientesModel(
        id: id,
        nombre: nombre,
        nroLibreta: nroLibreta,
        ci: ci,
      ));
      yield PacientesState.success();
    } catch (_) {
      print("===============");
      print(" Aca existe una falla PacientesState.failure()");
      print("===============");
      yield PacientesState.failure();
    }
  }
}
