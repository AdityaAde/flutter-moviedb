part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();
}

class MovieInitial extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieLoading extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieLoaded extends MovieState {
  final List<Movie> movieList;
  MovieLoaded(this.movieList);

  @override
  List<Object> get props => [movieList];
}

class MovieError extends MovieState {
  final String msgError;
  MovieError(this.msgError);

  @override
  List<Object> get props => [msgError];
}
