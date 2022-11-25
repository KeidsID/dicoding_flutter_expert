import 'package:equatable/equatable.dart';

class TvShow extends Equatable {
  TvShow({
    required this.posterPath,
    required this.popularity,
    required this.id,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.genreIds,
    required this.voteCount,
    required this.name,
    required this.originalName,
  });

  final String? posterPath;
  final double popularity;
  final int id;
  final String? backdropPath;
  final double voteAverage;
  final String overview;
  final List<int> genreIds;
  final int voteCount;
  final String name;
  final String originalName;

  @override
  List<Object?> get props {
    return [
      posterPath,
      popularity,
      id,
      backdropPath,
      voteAverage,
      overview,
      genreIds,
      voteCount,
      name,
      originalName,
    ];
  }
}
