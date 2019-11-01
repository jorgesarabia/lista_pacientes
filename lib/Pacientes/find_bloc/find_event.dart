import 'package:equatable/equatable.dart';

abstract class FindEvent extends Equatable {
  const FindEvent();

  @override
  List<Object> get props => [];
}

class QueryChanged extends FindEvent {
  // final String query;

  // const QueryChanged({@required this.query});

  // @override
  // List<Object> get props => [query];
// 
  // @override
  // String toString() => 'QueryChanged { query :$query }';
}
