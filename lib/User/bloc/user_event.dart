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

class PassChanged extends UserEvent {
  final String password;

  const PassChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PassChanged { password:$password }';
}

class RePassChanged extends UserEvent {
  final String password;

  const RePassChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'RePassChanged { password(retype) :$password }';
}

class UpdateUser extends UserEvent {
  final String nombre;
  final String password;

  const UpdateUser({
    @required this.nombre,
    @required this.password,
  });

  @override
  List<Object> get props => [nombre, password];

  @override
  String toString() {
    return '''
    ActualizarUser { 
      nombre: $nombre, 
      pass: $password,
    }''';
  }
}