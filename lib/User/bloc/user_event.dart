import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class NombreChanged extends UserEvent {
  final String nombre;

  const NombreChanged({@required this.nombre});

  @override
  List<Object> get props => [nombre];

  @override
  String toString() => 'NombreChanged { nombre :$nombre }';
}

class ActualPassChanged extends UserEvent {
  final String password;

  const ActualPassChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'ActualPassChanged { password:$password }';
}

class NewPassChanged extends UserEvent {
  final String password;

  const NewPassChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'NewPassChanged { password(new) :$password }';
}

class RetypeNewPassChanged extends UserEvent {
  final String password;

  const RetypeNewPassChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'RetypeNewPassChanged { password(retype) :$password }';
}

class UpdateUserName extends UserEvent {
  final String nombre;

  const UpdateUserName({
    @required this.nombre,
  });

  @override
  List<Object> get props => [nombre];

  @override
  String toString() {
    return '''
    ActualizarUserName { 
      nombre: $nombre, 
    }''';
  }
}

class UpdatePassword extends UserEvent {
  final String actualPassword;
  final String newPassword;

  const UpdatePassword({
    @required this.actualPassword,
    @required this.newPassword,
  });

  @override
  List<Object> get props => [actualPassword, newPassword];

  @override
  String toString() {
    return '''
    ActualizarPassword { 
      actual: $actualPassword, 
      nuevo: $newPassword, 
    }''';
  }
}