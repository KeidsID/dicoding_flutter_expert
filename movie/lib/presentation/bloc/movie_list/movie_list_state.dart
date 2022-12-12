part of 'movie_list_bloc.dart';

@immutable
class MovieListState extends Equatable {
  // np -> Now Playing
  // pop -> Popular
  // tr -> Top Rated

  final RequestState npState;
  final RequestState popState;
  final RequestState trState;

  final List<Movie> npResults;
  final List<Movie> popResults;
  final List<Movie> trResults;

  final String msg;

  const MovieListState({
    required this.npState,
    required this.popState,
    required this.trState,
    required this.npResults,
    required this.popResults,
    required this.trResults,
    required this.msg,
  });

  factory MovieListState.init() {
    return const MovieListState(
      npState: RequestState.empty,
      popState: RequestState.empty,
      trState: RequestState.empty,
      npResults: [],
      popResults: [],
      trResults: [],
      msg: '',
    );
  }

  MovieListState copyWith({
    RequestState? npState,
    RequestState? popState,
    RequestState? trState,
    List<Movie>? npResults,
    List<Movie>? popResults,
    List<Movie>? trResults,
    String? msg,
  }) {
    return MovieListState(
      npState: npState ?? this.npState,
      popState: popState ?? this.popState,
      trState: trState ?? this.trState,
      npResults: npResults ?? this.npResults,
      popResults: popResults ?? this.popResults,
      trResults: trResults ?? this.trResults,
      msg: msg ?? this.msg,
    );
  }

  @override
  List<Object?> get props {
    return [
      npState,
      popState,
      trState,
      npResults,
      popResults,
      trResults,
      msg,
    ];
  }
}
