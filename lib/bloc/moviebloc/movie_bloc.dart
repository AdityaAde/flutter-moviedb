import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_moviedb/models/movie.dart';
import 'package:flutter_moviedb/resource/api_provider.dart';
part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  ApiProvider _apiProvider = ApiProvider();
  MovieBloc() : super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is MovieEventStart) {
      try {
        yield MovieLoading();
        List<Movie> movieList = await _apiProvider.getNowPlaying();
        yield MovieLoaded(movieList);
        print('data di moviebloc ' + movieList.length.toString());
      } catch (e) {
        print('error di moviebloc $e');
      }
    }
  }
}
