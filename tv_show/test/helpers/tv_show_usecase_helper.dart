import 'package:mockito/annotations.dart';

import 'package:tv_show/domain/usecases/get_airing_today_tv_shows.dart';
import 'package:tv_show/domain/usecases/get_popular_tv_shows.dart';
import 'package:tv_show/domain/usecases/get_top_rated_tv_shows.dart';
import 'package:tv_show/domain/usecases/get_tv_show_detail.dart';
import 'package:tv_show/domain/usecases/get_tv_show_recommendations.dart';
import 'package:tv_show/domain/usecases/get_tv_show_watchlist_status.dart';
import 'package:tv_show/domain/usecases/get_watchlist_tv_shows.dart';
import 'package:tv_show/domain/usecases/remove_tv_show_from_watchlist.dart';
import 'package:tv_show/domain/usecases/save_tv_show_to_watchlist.dart';
import 'package:tv_show/domain/usecases/search_tv_shows.dart';

@GenerateMocks([
  GetAiringTodayTvShows,
  GetPopularTvShows,
  GetTopRatedTvShows,
  GetTvShowDetail,
  GetTvShowRecommendations,
  SearchTvShows,
  GetWatchlistTvShows,
  GetTvShowWatchlistStatus,
  SaveTvShowToWatchlist,
  RemoveTvShowFromWatchlist,
])
void main() {}
