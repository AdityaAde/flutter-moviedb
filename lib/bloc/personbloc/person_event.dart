part of 'person_bloc.dart';

abstract class PersonEvent extends Equatable {
  const PersonEvent();
}

class PersonEventStart implements PersonEvent {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}
