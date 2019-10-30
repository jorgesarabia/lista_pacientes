import 'package:meta/meta.dart';

// Se van a tener varios estados depende del uso:
// 1)- Al cargar los pacientes:
// 2)- Al crear los pacientes:
// 3)- Al actualizar los pacientes:
//
// i)-   Waiting:   Se esta esperando una respuesta.
// ii)-  Done:      Ya está.
// iii)- Failed:    Error.

@immutable
abstract class PacientesState {}
  
class InitialPacientesState extends PacientesState {}
class WaitingPacientesState extends PacientesState {}
class DonePacientesState extends PacientesState {}
class FailedPacientesState extends PacientesState {}
