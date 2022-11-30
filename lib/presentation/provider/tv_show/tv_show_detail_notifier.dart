import 'package:flutter/foundation.dart';

import '../../../common/state_enum.dart';

import '../../../domain/entities/tv_show.dart';
import '../../../domain/entities/tv_show_detail.dart';
import '../../../domain/usecases/tv_show_cases/get_tv_show_recommendations.dart';
import '../../../domain/usecases/tv_show_cases/get_tv_show_watchlist_status.dart';
import '../../../domain/usecases/tv_show_cases/get_tv_show_detail.dart';
import '../../../domain/usecases/tv_show_cases/remove_tv_show_from_watchlist.dart';
import '../../../domain/usecases/tv_show_cases/save_tv_show_to_watchlist.dart';

class TvShowDetailNotifier extends ChangeNotifier {
  static const addWatchlistSuccessMsg = 'Added to Watchlist';
  static const removeWatchlistSuccessMsg = 'Removed from Watchlist';

  TvShowDetailNotifier({
    required this.getTvShowDetail,
    required this.getTvShowRecommendations,
    required this.getWatchlistStatus,
    required this.saveToWatchliist,
    required this.removeFromWatchlist,
  });

  final GetTvShowDetail getTvShowDetail;
  final GetTvShowRecommendations getTvShowRecommendations;
  final GetTvShowWatchlistStatus getWatchlistStatus;
  final SaveTvShowToWatchlist saveToWatchliist;
  final RemoveTvShowFromWatchlist removeFromWatchlist;

  late TvShowDetail _tvShowDetail;
  var _detailState = RequestState.Empty;
  var _detailMsg = '';

  var _tvShowRecomm = <TvShow>[];
  var _recommState = RequestState.Empty;
  var _recommMsg = '';

  var _isWatchlisted = false;
  var _watchlistMsg = '';

  TvShowDetail get detailResult => _tvShowDetail;
  RequestState get detailState => _detailState;
  String get detailMsg => _detailMsg;

  List<TvShow> get recommResults => _tvShowRecomm;
  RequestState get recommState => _recommState;
  String get recommMsg => _recommMsg;

  bool get isWatchlisted => _isWatchlisted;
  String get watchlistMsg => _watchlistMsg;

  Future<void> fetchDetail(int id) async {
    _detailState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getTvShowDetail.execute(id);
    final recommResults = await getTvShowRecommendations.execute(id);

    detailResult.fold(
      (fail) {
        _detailState = RequestState.Error;
        _detailMsg = fail.message;
        notifyListeners();
      },
      (tvShow) {
        _recommState = RequestState.Loading;
        _tvShowDetail = tvShow;
        notifyListeners();

        recommResults.fold(
          (fail) {
            _recommState = RequestState.Error;
            _recommMsg = fail.message;
          },
          (tvShows) {
            _recommState = RequestState.Loaded;
            _tvShowRecomm = tvShows;
          },
        );
        _detailState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchlistStatus.execute(id);

    _isWatchlisted = result;
    notifyListeners();
  }

  Future<void> addToWatchlist(TvShowDetail tvShow) async {
    final result = await saveToWatchliist.execute(tvShow);

    await result.fold(
      (fail) => _watchlistMsg = fail.message,
      (success) => _watchlistMsg = success,
    );

    await loadWatchlistStatus(tvShow.id);
  }

  Future<void> deleteFromWatchlist(TvShowDetail tvShow) async {
    final result = await removeFromWatchlist.execute(tvShow);

    await result.fold(
      (fail) => _watchlistMsg = fail.message,
      (success) => _watchlistMsg = success,
    );

    await loadWatchlistStatus(tvShow.id);
  }
}
