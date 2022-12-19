part of 'tv_show_search_bloc.dart';

abstract class TvShowSearchEvent extends Equatable {
  const TvShowSearchEvent();

  @override
  List<Object> get props => [];
}

class OnDidChangeDep extends TvShowSearchEvent {
  const OnDidChangeDep();
}

class OnEmptyQuery extends TvShowSearchEvent {
  const OnEmptyQuery();
}

class OnQueryChanged extends TvShowSearchEvent {
  final String query;

  const OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}
