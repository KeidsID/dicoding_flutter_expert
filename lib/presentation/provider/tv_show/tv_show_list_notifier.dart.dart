import 'package:flutter/cupertino.dart';

import '../../../common/state_enum.dart';
import '../../../domain/entities/tv_show.dart';
import '../../../domain/usecases/tv_show_cases/get_on_air_tv_shows.dart';
import '../../../domain/usecases/tv_show_cases/get_popular_tv_shows.dart';
import '../../../domain/usecases/tv_show_cases/get_top_rated_tv_shows.dart';

class TvShowListNotifier extends ChangeNotifier {
  TvShowListNotifier({
    required this.getOnAirTvShows,
    required this.getPopularTvShows,
    required this.getTopRatedTvShows,
  });

  final GetOnAirTvShows getOnAirTvShows;
  final GetPopularTvShows getPopularTvShows;
  final GetTopRatedTvShows getTopRatedTvShows;

  var _onAirTvShows = <TvShow>[];
  var _popularTvShows = <TvShow>[];
  var _topRatedTvShows = <TvShow>[];

  var _onAirState = RequestState.Empty;
  var _popularState = RequestState.Empty;
  var _topRatedState = RequestState.Empty;

  var _message = '';

  List<TvShow> get onAirTvShows => _onAirTvShows;
  List<TvShow> get popularTvShows => _popularTvShows;
  List<TvShow> get topRatedTvShows => _topRatedTvShows;

  RequestState get onAirState => _onAirState;
  RequestState get popularState => _popularState;
  RequestState get topRatedState => _topRatedState;

  String get message => _message;

  Future<void> fetchOnAirTvShows() async {
    _onAirState = RequestState.Loading;
    notifyListeners();

    final result = await getOnAirTvShows.execute();
    result.fold(
      (failure) {
        _onAirState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (movies) {
        _onAirState = RequestState.Loaded;
        _onAirTvShows = movies;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvShows() async {
    _popularState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTvShows.execute();
    result.fold(
      (failure) {
        _popularState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (movies) {
        _popularState = RequestState.Loaded;
        _popularTvShows = movies;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvShows() async {
    _topRatedState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvShows.execute();
    result.fold(
      (failure) {
        _topRatedState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (movies) {
        _topRatedState = RequestState.Loaded;
        _topRatedTvShows = movies;
        notifyListeners();
      },
    );
  }
}
