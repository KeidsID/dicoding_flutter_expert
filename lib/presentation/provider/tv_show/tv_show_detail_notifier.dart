import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show_cases/get_tv_show_recommendations.dart';
import 'package:flutter/foundation.dart';

import '../../../common/state_enum.dart';
import '../../../domain/entities/tv_show_detail.dart';
import '../../../domain/usecases/tv_show_cases/get_tv_show_detail.dart';

class TvShowDetailNotifier extends ChangeNotifier {
  TvShowDetailNotifier({
    required this.getTvShowDetail,
    required this.getTvShowRecommendations,
  });

  final GetTvShowDetail getTvShowDetail;
  final GetTvShowRecommendations getTvShowRecommendations;

  late TvShowDetail _tvShowDetail;
  var _detailState = RequestState.Empty;
  var _detailMsg = '';

  var _tvShowRecomm = <TvShow>[];
  var _recommState = RequestState.Empty;
  var _recommMsg = '';

  TvShowDetail get detailResult => _tvShowDetail;
  RequestState get detailState => _detailState;
  String get detailMsg => _detailMsg;

  List<TvShow> get recommResults => _tvShowRecomm;
  RequestState get recommState => _recommState;
  String get recommMsg => _recommMsg;

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
}
