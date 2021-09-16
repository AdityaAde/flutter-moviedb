part of 'genre_bloc.dart';

abstract class GenreState extends Equatable {
  const GenreState();
}

class GenreInitial extends GenreState {
  @override
  List<Object> get props => [];
}

class GenreLoading extends GenreState {
  @override
  List<Object> get props => [];
}

class GenreLoaded extends GenreState {
  final List<Genre> genreList;
  GenreLoaded(this.genreList);

  @override
  List<Object> get props => [genreList];
}

class GenreError extends GenreState {
  final String msgError;
  GenreError(this.msgError);

  @override
  List<Object> get props => [msgError];
}
