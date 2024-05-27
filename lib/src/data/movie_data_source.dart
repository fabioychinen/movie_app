import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/src/models/movie_model.dart';

class MovieDataSource {
  final String apiKey = '88efd5107320ab503dcd9aae2c475996';
  final String _baseUrl = "https://api.themoviedb.org/3";
  final String _key = "?api_key=88efd5107320ab503dcd9aae2c475996";

  String get fetchPopular => "$_baseUrl/movie/popular$_key";
  String get fetchFreeToWatch => "$_baseUrl/movie/now_playing$_key";

  Future<List<MovieModel>> getMoviesFreeToWatch() async {
    try {
      final client = http.Client();
      final response = await client.get(Uri.parse(fetchFreeToWatch));

      if (response.statusCode == 200) {
        final List<dynamic> responseJson =
            json.decode(response.body)['results'];
        return responseJson.map((e) => MovieModel.fromMap(e)).toList();
      } else {
        throw Exception(
            'Failed to load movies (status code: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Failed to load movies: $e');
    }
  }

  Future<List<MovieModel>> getMoviesPopular() async {
    try {
      final client = http.Client();
      final response = await client.get(Uri.parse(fetchPopular));

      if (response.statusCode == 200) {
        final List<dynamic> responseJson =
            json.decode(response.body)['results'];
        return responseJson.map((e) => MovieModel.fromMap(e)).toList();
      } else {
        throw Exception(
            'Failed to load movies (status code: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Failed to load movies: $e');
    }
  }
}
