import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class PacientesEvent extends Equatable {
  const PacientesEvent();

  @override
  List<Object> get props => [];
}

class NombreChanged extends PacientesEvent {
  final String nombre;

  const NombreChanged({@required this.nombre});

  @override
  List<Object> get props => [nombre];

  @override
  String toString() => 'NombreChanged { nombre :$nombre }';
}

class CIChanged extends PacientesEvent {
  final String ci;

  const CIChanged({@required this.ci});

  @override
  List<Object> get props => [ci];

  @override
  String toString() => 'CIChanged { ci :$ci }';
}

class EmailChanged extends PacientesEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class NroLibretaChanged extends PacientesEvent {
  final String nroLibreta;

  const NroLibretaChanged({@required this.nroLibreta});

  @override
  List<Object> get props => [nroLibreta];

  @override
  String toString() => 'NroLibretaChanged { nroLibreta :$nroLibreta }';
}

class CrearNuevoPaciente extends PacientesEvent {
  final String nombre;
  final String nroLibreta;

  const CrearNuevoPaciente({
    @required this.nombre,
    @required this.nroLibreta,
  });

  @override
  List<Object> get props => [nombre, nroLibreta];

  @override
  String toString() {
    return 'CrearNuevoPaciente { nombre: $nombre, nroLibreta: $nroLibreta }';
  }
}
