part of 'tv_show_detail_bloc.dart';

abstract class TvShowDetailEvent extends Equatable {
  const TvShowDetailEvent();

  @override
  List<Object> get props => [];
}

class OnDidChangeDep extends TvShowDetailEvent {
  const OnDidChangeDep();
}

class OnFetchDetail extends TvShowDetailEvent {
  final int id;

  const OnFetchDetail(this.id);

  @override
  List<Object> get props => [id];
}

class OnLoadDbStatus extends TvShowDetailEvent {
  final int id;
  final String? msg;

  const OnLoadDbStatus(this.id, {this.msg});

  @override
  List<Object> get props => [id];
}

class OnAddToDb extends TvShowDetailEvent {
  final TvShowDetail movie;

  const OnAddToDb(this.movie);

  @override
  List<Object> get props => [movie];
}

class OnRemoveFromDb extends TvShowDetailEvent {
  final TvShowDetail movie;

  const OnRemoveFromDb(this.movie);

  @override
  List<Object> get props => [movie];
}
