import 'package:ditonton/domain/usecases/tv_show_cases/get_airing_today_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show_cases/get_popular_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show_cases/get_top_rated_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show_cases/get_tv_show_detail.dart';
import 'package:ditonton/domain/usecases/tv_show_cases/get_tv_show_recommendations.dart';
import 'package:ditonton/domain/usecases/tv_show_cases/get_tv_show_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tv_show_cases/get_watchlist_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show_cases/remove_tv_show_from_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_show_cases/save_tv_show_to_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_show_cases/search_tv_shows.dart';
import 'package:mockito/annotations.dart';

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
