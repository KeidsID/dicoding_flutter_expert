import 'package:equatable/equatable.dart';
import '../../../domain/entities/tv_show.dart';

class TvShowModel extends Equatable {
  TvShowModel({
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

  factory TvShowModel.fromJson(Map<String, dynamic> json) {
    return TvShowModel(
      posterPath: json['poster_path'],
      popularity: json['popularity'].toDouble(),
      id: json['id'].toInt(),
      backdropPath: json['backdrop_path'],
      voteAverage: json['vote_average'].toDouble(),
      overview: json['overview'],
      genreIds: List<int>.from(json['genre_ids'].map((x) => x)),
      voteCount: json['vote_count'].toInt(),
      name: json['name'],
      originalName: json['original_name'],
    );
  }

  TvShow toEntity() {
    return TvShow(
      posterPath: posterPath,
      popularity: popularity,
      id: id,
      backdropPath: backdropPath,
      voteAverage: voteAverage,
      overview: overview,
      genreIds: genreIds,
      voteCount: voteCount,
      name: name,
      originalName: originalName,
    );
  }

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
