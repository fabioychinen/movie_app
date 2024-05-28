import 'package:flutter/material.dart';
import 'package:movie_app/src/data/movie_data_source.dart';
import 'package:movie_app/src/models/movie_model.dart';

class MovieController extends ChangeNotifier {
  final MovieDataSource _movieDataSource = MovieDataSource();
  List<MovieModel> popularMovies = [];
  List<MovieModel> freeToWatchMovies = [];
  bool isLoading = false;

  Future<void> fetchMovies() async {
    try {
      isLoading = true;
      notifyListeners();

      popularMovies = await _movieDataSource.getMoviesPopular();
      freeToWatchMovies = await _movieDataSource.getMoviesFreeToWatch();

      isLoading = false;
      notifyListeners();
    } catch (e) {}
  }
}
