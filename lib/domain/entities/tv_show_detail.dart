import 'package:equatable/equatable.dart';

import 'genre.dart';

class TvShowDetail extends Equatable {
  TvShowDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.name,
    required this.numberOfEpisode,
    required this.numberOfSeason,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final String backdropPath;
  final List<Genre> genres;
  final int id;
  final String name;
  final int numberOfEpisode;
  final int numberOfSeason;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props {
    return [
      backdropPath,
      genres,
      id,
      name,
      numberOfEpisode,
      numberOfSeason,
      originalName,
      overview,
      popularity,
      posterPath,
      voteAverage,
      voteCount,
    ];
  }
}
