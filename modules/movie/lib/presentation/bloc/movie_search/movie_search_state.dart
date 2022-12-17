part of 'movie_search_bloc.dart';

@immutable
abstract class MovieSearchState extends Equatable {
  const MovieSearchState();
}

class SearchEmpty extends MovieSearchState {
  @override
  List<Object?> get props => [];
}

class SearchLoading extends MovieSearchState {
  @override
  List<Object?> get props => [];
}

class SearchError extends MovieSearchState {
  const SearchError(this.msg);

  final String msg;

  @override
  List<Object?> get props => [msg];
}

class SearchLoaded extends MovieSearchState {
  const SearchLoaded(this.results);

  final List<Movie> results;

  @override
  List<Object?> get props => [results];
}
