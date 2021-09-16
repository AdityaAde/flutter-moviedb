import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_moviedb/models/genre.dart';
import 'package:flutter_moviedb/resource/api_provider.dart';

part 'genre_event.dart';
part 'genre_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  ApiProvider _apiProvider = ApiProvider();
  GenreBloc() : super(GenreInitial());

  @override
  Stream<GenreState> mapEventToState(GenreEvent event) async* {
    if (event is GenreEventStart) {
      yield GenreLoading();
      try {
        List<Genre> genreList = await _apiProvider.getGenreList();
        yield GenreLoaded(genreList);
      } on Exception catch (e) {
        print(e);
        throw Exception('error di genrebloc $e');
      }
    }
  }
}
