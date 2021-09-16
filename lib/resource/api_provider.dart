import 'dart:convert';

import 'package:flutter_moviedb/consts/apiUrl.dart';
import 'package:flutter_moviedb/models/genre.dart';
import 'package:flutter_moviedb/models/movie.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  //getNowPlaying
  Future<List<Movie>> getNowPlaying() async {
    try {
      final url = '$baseApiUrl/movie/now_playing?$apiKey';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final result = data['results'] as List;
        List<Movie> movieList = result.map((m) => Movie.fromJson(m)).toList();
        //print('data getplaying ' + movieList.length.toString());
        return movieList;
      } else {
        return throw Exception('error getnowplaying');
      }
    } catch (e) {
      print('error getnowplaying api $e');
      throw Exception('error di api getnowplaying $e');
    }
  }

  //get Movie By Genre
  Future<List<Movie>> getMovieGenre(int movieId) async {
    try {
      final url = '$baseApiUrl/discover/movie?with_genres=$movieId&$apiKey';
      final response = await http.get(Uri.parse(url));
      final result = jsonDecode(response.body);
      var movies = result['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  //get genre list
  Future<List<Genre>> getGenreList() async {
    try {
      final url = '$baseApiUrl/genre/movie/list?$apiKey';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final result = data['genres'] as List;
        List<Genre> movieList = result.map((g) => Genre.fromJson(g)).toList();

        return movieList;
      } else {
        return throw Exception('error get genre');
      }
    } catch (e) {
      print('error get genre $e');
      throw Exception('error get genre');
    }
  }
}
