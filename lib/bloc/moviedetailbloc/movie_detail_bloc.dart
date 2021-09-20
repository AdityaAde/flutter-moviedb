import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_moviedb/models/movie_detail.dart';
import 'package:flutter_moviedb/resource/api_provider.dart';
part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final ApiProvider _apiProvider = ApiProvider();
  MovieDetailBloc() : super(MovieDetailInitial());

  @override
  Stream<MovieDetailState> mapEventToState(MovieDetailEvent event) async* {
    if (event is MovieDetailEventStart) {
      yield* _mapEventStateToState(event.id);
    }
  }

  Stream<MovieDetailState> _mapEventStateToState(int id) async* {
    yield MovieDetailLoading();
    try {
      final movieDetail = await _apiProvider.getMovieDetail(id);
      yield MovieDetailLoaded(movieDetail);
    } catch (e) {
      print('movie detail bloc error $e');
    }
  }
}
