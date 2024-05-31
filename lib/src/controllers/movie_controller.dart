import 'package:flutter/material.dart';
import 'package:movie_app/src/data/movie_data_source.dart';
import 'package:movie_app/src/models/movie_model.dart';
import 'package:movie_app/src/view/movie_detail_page.dart';

class MovieController extends ChangeNotifier {
  final MovieDataSource _movieDataSource = MovieDataSource();
  List<MovieModel> _popularMovies = [];
  List<MovieModel> _freeToWatchMovies = [];
  bool _isLoading = true;

  List<MovieModel> get popularMovies => _popularMovies;
  List<MovieModel> get freeToWatchMovies => _freeToWatchMovies;
  bool get isLoading => _isLoading;

  MovieController() {
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      final popularMovies = await _movieDataSource.getMoviesPopular();
      final freeToWatchMovies = await _movieDataSource.getMoviesFreeToWatch();
      _popularMovies = popularMovies;
      _freeToWatchMovies = freeToWatchMovies;
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Color getVoteColor(double vote) {
    if (vote >= 7.0) {
      return Colors.green;
    } else if (vote >= 4.0) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  void showMovieDescription(MovieModel movie, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailPage(movie: movie),
      ),
    );
  }
}
