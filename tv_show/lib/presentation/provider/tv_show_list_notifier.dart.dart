import 'package:flutter/cupertino.dart';

import 'package:core/common/state_enum.dart';
import '../../domain/entities/tv_show.dart';

import '../../domain/usecases/get_airing_today_tv_shows.dart';
import '../../domain/usecases/get_popular_tv_shows.dart';
import '../../domain/usecases/get_top_rated_tv_shows.dart';

class TvShowListNotifier extends ChangeNotifier {
  TvShowListNotifier({
    required this.getOnAirTvShows,
    required this.getPopularTvShows,
    required this.getTopRatedTvShows,
  });

  final GetAiringTodayTvShows getOnAirTvShows;
  final GetPopularTvShows getPopularTvShows;
  final GetTopRatedTvShows getTopRatedTvShows;

  var _airingTodayTvShows = <TvShow>[];
  var _popularTvShows = <TvShow>[];
  var _topRatedTvShows = <TvShow>[];

  var _airingTodayState = RequestState.empty;
  var _popularState = RequestState.empty;
  var _topRatedState = RequestState.empty;

  var _message = '';

  List<TvShow> get airingTodayTvShows => _airingTodayTvShows;
  List<TvShow> get popularTvShows => _popularTvShows;
  List<TvShow> get topRatedTvShows => _topRatedTvShows;

  RequestState get airingTodayState => _airingTodayState;
  RequestState get popularState => _popularState;
  RequestState get topRatedState => _topRatedState;

  String get message => _message;

  Future<void> fetchAiringTodayTvShows() async {
    _airingTodayState = RequestState.loading;
    notifyListeners();

    final result = await getOnAirTvShows.execute();
    result.fold(
      (failure) {
        _airingTodayState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (movies) {
        _airingTodayState = RequestState.loaded;
        _airingTodayTvShows = movies;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvShows() async {
    _popularState = RequestState.loading;
    notifyListeners();

    final result = await getPopularTvShows.execute();
    result.fold(
      (failure) {
        _popularState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (movies) {
        _popularState = RequestState.loaded;
        _popularTvShows = movies;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvShows() async {
    _topRatedState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTvShows.execute();
    result.fold(
      (failure) {
        _topRatedState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (movies) {
        _topRatedState = RequestState.loaded;
        _topRatedTvShows = movies;
        notifyListeners();
      },
    );
  }
}