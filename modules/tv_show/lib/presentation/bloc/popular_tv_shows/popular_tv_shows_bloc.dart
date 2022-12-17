import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/domain/entities/tv_show.dart';
import 'package:tv_show/domain/usecases/get_popular_tv_shows.dart';

part 'popular_tv_shows_event.dart';
part 'popular_tv_shows_state.dart';

class PopularTvShowsBloc
    extends Bloc<PopularTvShowsEvent, PopularTvShowsState> {
  final GetPopularTvShows usecase;

  PopularTvShowsBloc(this.usecase) : super(const InitState()) {
    on<OnFetchTvShows>((event, emit) async {
      final page = event.page;

      emit(const Loading());
      final getTvShows = await usecase.execute(page: page);

      getTvShows.fold(
        (l) => emit(Error(l.message)),
        (r) => emit(HasData(r)),
      );
    });
  }
}
