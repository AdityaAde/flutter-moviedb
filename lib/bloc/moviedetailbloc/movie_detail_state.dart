part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail detail;
  MovieDetailLoaded(this.detail);
  @override
  List<Object> get props => [detail];
}

class MovieDetailError extends MovieDetailState {
  final String msgError;
  MovieDetailError(this.msgError);
  @override
  List<Object> get props => [msgError];
}
