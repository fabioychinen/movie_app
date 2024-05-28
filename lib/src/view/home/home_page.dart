import 'package:flutter/material.dart';
import 'package:movie_app/src/data/movie_data_source.dart';
import 'package:movie_app/src/models/movie_model.dart';
import 'package:movie_app/src/view/details/movie_detail_page.dart';
import 'package:movie_app/src/widgets/card_movie_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MovieDataSource _movieDataSource = MovieDataSource();
  List<MovieModel> _popularMovies = [];
  List<MovieModel> _freeToWatchMovies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    try {
      final popularMovies = await _movieDataSource.getMoviesPopular();
      final freeToWatchMovies = await _movieDataSource.getMoviesFreeToWatch();
      setState(() {
        _popularMovies = popularMovies;
        _freeToWatchMovies = freeToWatchMovies;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showMovieDescription(MovieModel movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailPage(movie: movie),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filmes e Séries'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 5, top: 50),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text(
                    'Os Mais Populares',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                _buildMovieList(_popularMovies),
                Container(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: const Text(
                    'Grátis Para Assistir',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                _buildMovieList(_freeToWatchMovies),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMovieList(List<MovieModel> movies) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (movies.isEmpty) {
      return const Center(
        child: Text('Nenhum filme encontrado'),
      );
    } else {
      return SizedBox(
        height: 280,
        width: double.infinity,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            final movie = movies[index];
            return GestureDetector(
              onTap: () {
                _showMovieDescription(movie);
              },
              child: CardMovieWidget(
                movie: movie,
                onTap: _showMovieDescription,
              ),
            );
          },
        ),
      );
    }
  }
}
