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
    } else if (event is ActualPassChanged) {
      yield* _mapActualPassChangedToState(event.password);
    } else if (event is NewPassChanged) {
      yield* _mapNewPassChangedToState(event.password);
    } else if (event is RetypeNewPassChanged) {
      yield* _mapRetypeNewPassChangedToState(event.password);
    } else if (event is UpdateUserName) {
      yield* _mapUpdateUserNameToState(
        nombre: event.nombre,
      );
    } else if (event is UpdatePassword) {
      yield* _mapUpdatePasswordToState(
        actualPassword: event.actualPassword,
        newPassword: event.newPassword,
      );
    }
  }

  Stream<UserState> _mapNombreChangedToState(String nombre) async* {
    yield state.update(
      isNameValid: nombre.isNotEmpty,
    );
  }

  Stream<UserState> _mapActualPassChangedToState(String password) async* {
    yield state.update(isActualPassValid: true, password: password);
  }

  Stream<UserState> _mapNewPassChangedToState(String password) async* {
    yield state.update(
      isNewPassValid: password.length > 6,
    );
  }

  Stream<UserState> _mapRetypeNewPassChangedToState(String password) async* {
    yield state.update(
      isRetypeNewPassValid: password.length > 6,
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

  Stream<UserState> _mapUpdatePasswordToState({
    String actualPassword,
    String newPassword,
  }) async* {
    yield UserState.loading();
    try {
      await repository.updatePassword(actualPassword,newPassword);
      yield UserState.success();
    } catch (_) {
      print("===============");
      print("No reseteó el password");
      print("===============");
      yield UserState.failure();
    }
  }
}
