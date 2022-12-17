part of 'movie_search_bloc.dart';

@immutable
abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();

  @override
  List<Object?> get props => [];
}

class OnDidChangeDep extends MovieSearchEvent {
  const OnDidChangeDep();
}

class OnQueryChanged extends MovieSearchEvent {
  const OnQueryChanged(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}
