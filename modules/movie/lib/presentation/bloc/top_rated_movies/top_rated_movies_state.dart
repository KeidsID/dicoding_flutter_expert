part of 'top_rated_movies_bloc.dart';

class TopRatedMoviesState extends Equatable {
  final RequestState state;
  final List<Movie> results;
  final String msg;

  const TopRatedMoviesState(
    this.state,
    this.results,
    this.msg,
  );

  factory TopRatedMoviesState.init() {
    return const TopRatedMoviesState(RequestState.empty, [], '');
  }

  @override
  List<Object> get props => [state, results, msg];

  TopRatedMoviesState copyWith({
    RequestState? state,
    List<Movie>? results,
    String? msg,
  }) {
    return TopRatedMoviesState(
      state ?? this.state,
      results ?? this.results,
      msg ?? this.msg,
    );
  }
}
