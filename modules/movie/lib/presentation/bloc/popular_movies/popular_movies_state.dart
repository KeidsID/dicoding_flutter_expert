part of 'popular_movies_bloc.dart';

class PopularMoviesState extends Equatable {
  final RequestState state;
  final List<Movie> results;
  final String msg;

  const PopularMoviesState(
    this.state,
    this.results,
    this.msg,
  );

  factory PopularMoviesState.init() {
    return const PopularMoviesState(RequestState.empty, [], '');
  }

  @override
  List<Object> get props => [state, results, msg];

  PopularMoviesState copyWith({
    RequestState? state,
    List<Movie>? results,
    String? msg,
  }) {
    return PopularMoviesState(
      state ?? this.state,
      results ?? this.results,
      msg ?? this.msg,
    );
  }
}
