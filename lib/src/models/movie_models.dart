import 'dart:ffi';

class MovieModels {
  String title;
  String posterPath;
  String releaseDate;
  Double? voteRating;

  MovieModels({
    required this.title,
    required this.posterPath,
    required this.releaseDate,
    this.voteRating,
  });
}
