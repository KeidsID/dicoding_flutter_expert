import 'package:equatable/equatable.dart';
import '../../domain/entities/tv_show.dart';
import '../../domain/entities/tv_show_detail.dart';

class TvShowTable extends Equatable {
  const TvShowTable({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
  });

  final int id;
  final String name;
  final String overview;
  final String posterPath;

  factory TvShowTable.fromDb(Map<String, dynamic> map) {
    return TvShowTable(
      id: map['id'],
      name: map['name'],
      overview: map['overview'],
      posterPath: map['posterPath'],
    );
  }

  Map<String, dynamic> toDb() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'posterPath': posterPath,
    };
  }

  factory TvShowTable.fromEntity(TvShowDetail tvShow) {
    return TvShowTable(
      id: tvShow.id,
      name: tvShow.name,
      overview: tvShow.overview,
      posterPath: tvShow.posterPath,
    );
  }

  TvShow toEntity() {
    return TvShow.watchlist(
      id: id,
      name: name,
      overview: overview,
      posterPath: posterPath,
    );
  }

  @override
  List<Object?> get props => [id, name, overview, posterPath];
}
