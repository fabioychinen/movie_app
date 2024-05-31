import 'dart:convert';

class MovieModel {
  String? posterPath;
  String? releaseDate;
  String? title;
  double? voteAverage;
  String? overview;

  MovieModel({
    this.posterPath,
    this.releaseDate,
    this.title,
    this.voteAverage,
    this.overview,
  });

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      posterPath:
          map['poster_path'] != null ? map['poster_path'] as String : null,
      releaseDate:
          map['release_date'] != null ? map['release_date'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      voteAverage: map['vote_average'] != null
          ? double.parse(map['vote_average'].toString())
          : null,
      overview: map['overview'] != null ? map['overview'] as String : null,
    );
  }

  factory MovieModel.fromJson(String source) =>
      MovieModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return {
      'poster_path': posterPath,
      'release_date': releaseDate,
      'title': title,
      'vote_average': voteAverage,
      'overview': overview,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'MovieModel(posterPath: $posterPath, releaseDate: $releaseDate, title: $title, voteAverage: $voteAverage, overview: $overview)';
  }
}
