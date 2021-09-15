part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class MovieEventStart implements MovieEvent {
  final int movieId;
  final String query;
  MovieEventStart(this.movieId, this.query);

  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}
