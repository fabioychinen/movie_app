import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/src/models/movie_model.dart';

class CardMovieWidget extends StatelessWidget {
  final MovieModel movie;

  const CardMovieWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        focusColor: const Color.fromARGB(24, 158, 158, 158),
        highlightColor: const Color.fromARGB(24, 158, 158, 158),
        onTap: () {},
        child: SizedBox(
          width: 120,
          child: Column(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                movie.title ?? 'Carregando',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                DateFormat("dd 'de' MMM 'de' y", "pt_BR")
                    .format(DateTime.parse(movie.releaseDate!)),
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
