import 'package:ditonton/domain/entities/tv_show_detail.dart';

import '../genre_model.dart';

class TvShowDetailModel {
  TvShowDetailModel({
    required this.backdropPath,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final String backdropPath;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final double voteAverage;
  final int voteCount;

  factory TvShowDetailModel.fromJson(Map<String, dynamic> json) {
    return TvShowDetailModel(
      backdropPath: json["backdrop_path"],
      genres: List<GenreModel>.from(
        json["genres"].map((x) => GenreModel.fromJson(x)),
      ),
      homepage: json["homepage"],
      id: json["id"],
      name: json["name"],
      numberOfEpisodes: json["number_of_episodes"],
      numberOfSeasons: json["number_of_seasons"],
      originalName: json["original_name"],
      overview: json["overview"],
      popularity: json["popularity"].toDouble(),
      posterPath: json["poster_path"],
      voteAverage: json["vote_average"].toDouble(),
      voteCount: json["vote_count"],
    );
  }

  TvShowDetail toEntity() {
    return TvShowDetail(
      backdropPath: backdropPath,
      genres: genres.map((e) => e.toEntity()).toList(),
      id: id,
      name: name,
      numberOfEpisodes: numberOfEpisodes,
      numberOfSeasons: numberOfSeasons,
      originalName: originalName,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }
}
