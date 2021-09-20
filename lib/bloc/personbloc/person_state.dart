part of 'person_bloc.dart';

abstract class PersonState extends Equatable {
  const PersonState();
}

class PersonInitial extends PersonState {
  @override
  List<Object> get props => [];
}

class PersonLoading extends PersonState {
  @override
  List<Object> get props => [];
}

class PersonLoaded extends PersonState {
  final List<Person> personList;
  PersonLoaded(this.personList);
  @override
  List<Object> get props => [personList];
}

class PersonError extends PersonState {
  final String msgError;
  PersonError(this.msgError);
  @override
  List<Object> get props => [msgError];
}
