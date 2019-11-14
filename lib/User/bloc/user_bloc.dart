import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:lista_pacientes/User/repository/cloud_firestore_repository.dart';
import 'package:lista_pacientes/common/validators.dart';
import './bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  Validators validators = Validators();
  CloudFirestoreRepository repository = CloudFirestoreRepository();

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
    } else if (event is UpdateUserName) {
      yield* _mapUpdateUserNameToState(
        nombre: event.nombre,
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

  Stream<UserState> _mapUpdateUserNameToState({
    String nombre,
  }) async* {
    yield UserState.loading();
    try {
      await repository.updateUserNames(nombre);
      yield UserState.success();
    } catch (_) {
      print("===============");
      print(" Aca existe una falla UserState.failure()");
      print("===============");
      yield UserState.failure();
    }
  }
}
