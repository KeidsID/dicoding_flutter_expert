part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  final RequestState blocState;

  final MovieDetail? movieDetail;
  final List<Movie> recomms;
  final bool watchlistStatus;

  final String blocStateMsg;
  final String watchlistMsg;

  const MovieDetailState({
    required this.blocState,
    required this.movieDetail,
    required this.recomms,
    required this.watchlistStatus,
    required this.blocStateMsg,
    required this.watchlistMsg,
  });

  factory MovieDetailState.init() {
    return const MovieDetailState(
      blocState: RequestState.empty,
      movieDetail: null,
      recomms: [],
      watchlistStatus: false,
      blocStateMsg: '',
      watchlistMsg: '',
    );
  }

  @override
  List<Object?> get props {
    return [
      blocState,
      movieDetail,
      recomms,
      watchlistStatus,
      blocStateMsg,
      watchlistMsg,
    ];
  }

  MovieDetailState copyWith({
    RequestState? blocState,
    MovieDetail? movieDetail,
    List<Movie>? recomms,
    bool? watchlistStatus,
    String? blocStateMsg,
    String? watchlistMsg,
  }) {
    return MovieDetailState(
      blocState: blocState ?? this.blocState,
      movieDetail: movieDetail ?? this.movieDetail,
      recomms: recomms ?? this.recomms,
      watchlistStatus: watchlistStatus ?? this.watchlistStatus,
      blocStateMsg: blocStateMsg ?? this.blocStateMsg,
      watchlistMsg: watchlistMsg ?? this.watchlistMsg,
    );
  }
}
