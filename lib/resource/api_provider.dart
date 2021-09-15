import 'dart:convert';

import 'package:flutter_moviedb/consts/apiUrl.dart';
import 'package:flutter_moviedb/models/movie.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  Future<List<Movie>> getNowPlaying() async {
    try {
      final url = '$baseApiUrl/movie/now_playing?$apiKey';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print(response.statusCode);
        final data = jsonDecode(response.body);
        final result = data['results'] as List;
        List<Movie> movieList = result.map((m) => Movie.fromJson(m)).toList();
        print('data getplaying ' + movieList.length.toString());
        return movieList;
      } else {
        return throw Exception('error getnowplaying');
      }
    } catch (e) {
      print('error getnowplaying api $e');
      throw Exception('error di api getnowplaying $e');
    }
  }
}
