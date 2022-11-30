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

  TvShow.watchlist({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
  });

  String? posterPath;
  double? popularity;
  int id;
  String? backdropPath;
  double? voteAverage;
  String overview;
  List<int>? genreIds;
  int? voteCount;
  String name;
  String? originalName;

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
