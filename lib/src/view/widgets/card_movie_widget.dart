import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/src/controllers/movie_controller.dart';
import 'package:movie_app/src/models/movie_model.dart';
import 'package:provider/provider.dart';

class CardMovieWidget extends StatelessWidget {
  final MovieModel movie;
  final Function onTap;

  const CardMovieWidget({
    super.key,
    required this.movie,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieController>(
      builder: (context, movieController, _) {
        double voteAverage = movie.voteAverage ?? 0;

        return Container(
          padding: const EdgeInsets.all(7),
          child: InkWell(
            borderRadius: BorderRadius.circular(6),
            focusColor: const Color.fromARGB(24, 158, 158, 158),
            highlightColor: const Color.fromARGB(24, 158, 158, 158),
            onTap: () {
              onTap();
            },
            child: SizedBox(
              width: 120,
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
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
                      Positioned(
                        bottom: -20,
                        left: 8,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator(
                                value: voteAverage / 10,
                                backgroundColor: Colors.black12,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  movieController.getVoteColor(voteAverage),
                                ),
                              ),
                            ),
                            Text(
                              '${(voteAverage * 10).toStringAsFixed(0)}%',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    movie.title != null
                        ? _truncateString(movie.title!, 20)
                        : 'Loading...',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    DateFormat("dd MMM y", "pt_BR")
                        .format(DateTime.parse(movie.releaseDate!)),
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _truncateString(String string, int maxLength) {
    return string.length <= maxLength
        ? string
        : '${string.substring(0, maxLength)}...';
  }
}
