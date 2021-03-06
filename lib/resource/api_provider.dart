import 'dart:convert';
import 'package:flutter_moviedb/consts/apiUrl.dart';
import 'package:flutter_moviedb/models/genre.dart';
import 'package:flutter_moviedb/models/movie.dart';
import 'package:flutter_moviedb/models/movie_detail.dart';
import 'package:flutter_moviedb/models/person.dart';
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

  //get list cast person
  Future<List<Person>> getPerson() async {
    try {
      final url = '$baseApiUrl/trending/person/week?$apiKey';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final result = data['results'] as List;
        List<Person> personList =
            result.map((p) => Person.fromJson(p)).toList();
        return personList;
      } else {
        return throw Exception('error get person');
      }
    } catch (e) {
      print('error get person $e');
      throw Exception('error get person');
    }
  }

  // ignore: missing_return
  Future<MovieDetail> getMovieDetail(int movieId) async {
    try {
      final url = '$baseApiUrl/movie/$movieId?$apiKey';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final dataMovie = jsonDecode(response.body);
        MovieDetail movieDetail = MovieDetail.fromJson(dataMovie);
        movieDetail.trailerId = await getYoutubeId(movieId);
        movieDetail.movieImage = await getMovieImage(movieId);
        movieDetail.castList = await getCastList(movieId);
        return movieDetail;
      }
    } catch (e) {
      throw Exception('error getmoviedetail api $e');
    }
  }

  // ignore: missing_return
  Future<String> getYoutubeId(int id) async {
    try {
      final url = '$baseApiUrl/movie/$id/videos?$apiKey';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        var youtubeId = data['results'][0]['key'];
        return youtubeId;
      }
    } catch (e) {
      throw Exception('get yt error $e');
    }
  }

  // ignore: missing_return
  Future<MovieImage> getMovieImage(int movieId) async {
    try {
      final url = '$baseApiUrl/movie/$movieId/images?$apiKey';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return MovieImage.fromJson(data);
      }
    } catch (e) {
      print('error get movie image $e');
    }
  }

  // ignore: missing_return
  Future<List<Cast>> getCastList(int movieId) async {
    try {
      final url = '$baseApiUrl/movie/$movieId/credits?$apiKey';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        var list = data['cast'] as List;
        List<Cast> castList = list
            .map(
              (c) => Cast(
                name: c['name'],
                profilePath: c['profile_path'],
                character: c['character'],
              ),
            )
            .toList();
        return castList;
      }
    } catch (e) {
      print('error get cast list $e');
    }
  }
}
