import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/src/models/movie_model.dart';

class MovieDetailPage extends StatelessWidget {
  final MovieModel movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    double voteAverage = movie.voteAverage ?? 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title ?? ''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              fit: BoxFit.cover,
              height: 300,
            ),
            const SizedBox(height: 20),
            Text(
              'Título: ${movie.title ?? ''}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Data de Lançamento: ${movie.releaseDate ?? ''}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: voteAverage / 10,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        getVoteColor(voteAverage),
                      ),
                    ),
                    Text(
                      '${(voteAverage * 10).toStringAsFixed(0)}%',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Text(
                  'Avaliação: ${voteAverage.toString()}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              Intl.message(
                'Sinopse:',
                name: 'movieDetailSynopsis',
                locale: 'pt_BR',
                desc: 'Label for movie synopsis',
                meaning: 'Sinopse do filme',
                args: [],
              ),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              movie.overview ??
                  Intl.message('Sinopse não disponível', locale: 'pt_BR'),
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
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
}
