part of 'genre_bloc.dart';

abstract class GenreEvent extends Equatable {
  const GenreEvent();
}

class GenreEventStart implements GenreEvent {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}
