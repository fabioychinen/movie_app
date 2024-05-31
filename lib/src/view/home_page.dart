import 'package:flutter/material.dart';
import 'package:movie_app/src/controllers/movie_controller.dart';
import 'package:movie_app/src/models/movie_model.dart';
import 'package:movie_app/src/view/widgets/card_movie_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieController>(
      builder: (context, movieController, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Filmes e Séries',
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(
                left: 5,
                top: 50,
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: const Text(
                        'Os Mais Populares',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    _buildMovieList(movieController.popularMovies,
                        movieController.isLoading),
                    Container(
                      padding: const EdgeInsets.only(
                        left: 10,
                        bottom: 10,
                      ),
                      child: const Text(
                        'Grátis Para Assistir',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    _buildMovieList(
                      movieController.freeToWatchMovies,
                      movieController.isLoading,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMovieList(List<MovieModel> movies, bool isLoading) {
    if (isLoading) {
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
                Provider.of<MovieController>(
                  context,
                  listen: false,
                ).showMovieDescription(movie, context);
              },
              child: CardMovieWidget(
                movie: movie,
                onTap: () {
                  Provider.of<MovieController>(
                    context,
                    listen: false,
                  ).showMovieDescription(movie, context);
                },
              ),
            );
          },
        ),
      );
    }
  }
}
