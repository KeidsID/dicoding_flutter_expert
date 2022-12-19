import 'package:equatable/equatable.dart';

import 'package:core/entities/genre.dart';

class TvShowDetail extends Equatable {
  const TvShowDetail({
    required this.backdropPath,
    required this.genres,
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
  final List<Genre> genres;
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

  @override
  List<Object?> get props {
    return [
      backdropPath,
      genres,
      id,
      name,
      numberOfEpisodes,
      numberOfSeasons,
      originalName,
      overview,
      popularity,
      posterPath,
      voteAverage,
      voteCount,
    ];
  }
}
