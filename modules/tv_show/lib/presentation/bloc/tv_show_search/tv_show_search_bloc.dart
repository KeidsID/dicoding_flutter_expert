import 'package:core/common/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/domain/entities/tv_show.dart';
import 'package:tv_show/domain/usecases/search_tv_shows.dart';

part 'tv_show_search_event.dart';
part 'tv_show_search_state.dart';

class TvShowSearchBloc extends Bloc<TvShowSearchEvent, TvShowSearchState> {
  final SearchTvShows searchTvShows;

  TvShowSearchBloc(this.searchTvShows) : super(const InitState()) {
    on<OnDidChangeDep>((_, emit) => emit(const InitState()));
    on<OnEmptyQuery>(
      (_, emit) => emit(const InitState()),
      transformer: blocDebounceTime(const Duration(milliseconds: 500)),
    );
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;

        emit(const Loading());
        final getSearch = await searchTvShows.execute(query);

        getSearch.fold(
          (l) => emit(Error(l.message)),
          (r) => emit(HasData(r)),
        );
      },
      transformer: blocDebounceTime(const Duration(milliseconds: 500)),
    );
  }
}
