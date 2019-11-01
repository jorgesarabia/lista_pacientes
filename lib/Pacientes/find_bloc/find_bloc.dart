import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:lista_pacientes/Pacientes/find_bloc/bloc.dart';
import 'package:lista_pacientes/Pacientes/model/pacientes_model.dart';
import 'package:lista_pacientes/Pacientes/repository/pacientes_repository.dart';

class FindBloc extends Bloc<FindEvent, FindState> {
  final PacientesRepository _pacientesRepository = PacientesRepository();
  @override
  FindState get initialState => FindState.loading();

  @override
  Stream<FindState> mapEventToState(FindEvent event) async* {
    if (event is QueryChanged) {
      yield* _mapBuscandoToState();
    }
  }

  Stream<FindState> _mapBuscandoToState() async* {
    yield FindState.loading();
    try {
      List<PacientesModel> lista = await _pacientesRepository.getPacientes();
      yield FindState.success(list: lista);
    } catch (_) {
      yield FindState.failure();
    }
  }
}
