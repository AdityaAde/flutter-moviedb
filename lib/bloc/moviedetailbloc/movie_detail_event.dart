part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
}

class MovieDetailEventStart implements MovieDetailEvent {
  final int id;
  MovieDetailEventStart(this.id);
  @override
  List<Object> get props => [];

  @override
  bool get stringify => false;
}
