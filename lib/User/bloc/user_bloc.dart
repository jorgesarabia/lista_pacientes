import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:lista_pacientes/common/validators.dart';
import './bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  Validators validators = Validators();

  @override
  UserState get initialState => UserState.empty();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is NombreChanged) {
      yield* _mapNombreChangedToState(event.nombre);
    } else if (event is PassChanged) {
      yield* _mapPassChangedToState(event.password);
    } else if (event is RePassChanged) {
      yield* _mapRePassChangedToState(event.password);
    } else if (event is UpdateUser) {
      yield* _mapUpdateUserToState(
        nombre: event.nombre,
        password: event.password,
      );
    }
  }

  Stream<UserState> _mapNombreChangedToState(String nombre) async* {
    yield state.update(
      isNameValid: nombre.isNotEmpty,
    );
  }

  Stream<UserState> _mapPassChangedToState(String password) async* {
    yield state.update(
      isPassValid: password.isNotEmpty,
      password: password
    );
  }

  Stream<UserState> _mapRePassChangedToState(String password) async* {
    yield state.update(
      isPassValid: password.isNotEmpty && state.password == password,
    );
  }

  Stream<UserState> _mapUpdateUserToState({
    String nombre,
    String password,
  }) async* {
    yield UserState.loading();
    try {
      yield UserState.success();
    } catch (_) {
      print("===============");
      print(" Aca existe una falla UserState.failure()");
      print("===============");
      yield UserState.failure();
    }
  }
}
