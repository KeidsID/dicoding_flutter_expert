import 'package:equatable/equatable.dart';
import '../models/tv_show_model.dart';

class TvShowResponse extends Equatable {
  const TvShowResponse({
    required this.page,
    required this.results,
    required this.totalResults,
    required this.totalPages,
  });

  final int page;
  final List<TvShowModel> results;
  final int totalResults;
  final int totalPages;

  factory TvShowResponse.fromJson(Map<String, dynamic> json) {
    return TvShowResponse(
      page: json['page'].toInt(),
      results: List<TvShowModel>.from(
        (json['results'] as List).map((e) => TvShowModel.fromJson(e)).where(
          (e) {
            return e.posterPath != null && e.backdropPath != null;
          },
        ),
      ),
      totalResults: json['total_results'].toInt(),
      totalPages: json['total_pages'].toInt(),
    );
  }

  @override
  List<Object?> get props => [page, results, totalResults, totalPages];
}
