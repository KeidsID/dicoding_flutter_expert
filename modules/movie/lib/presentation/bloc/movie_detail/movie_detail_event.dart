part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object?> get props => [];
}

class OnDidChangeDep extends MovieDetailEvent {
  const OnDidChangeDep();
}

class OnFetchDetail extends MovieDetailEvent {
  final int id;

  const OnFetchDetail(this.id);

  @override
  List<Object?> get props => [id];
}

class OnLoadDbStatus extends MovieDetailEvent {
  final int id;
  final String? msg;

  const OnLoadDbStatus(this.id, {this.msg});

  @override
  List<Object?> get props => [id];
}

class OnAddToDb extends MovieDetailEvent {
  final MovieDetail movie;

  const OnAddToDb(this.movie);

  @override
  List<Object?> get props => [movie];
}

class OnRemoveFromDb extends MovieDetailEvent {
  final MovieDetail movie;

  const OnRemoveFromDb(this.movie);

  @override
  List<Object?> get props => [movie];
}
