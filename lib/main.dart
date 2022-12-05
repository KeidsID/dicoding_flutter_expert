import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/movie_home_page.dart.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/tv_show/airing_today_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/tv_show/popular_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/tv_show/search_tv_show_page.dart';
import 'package:ditonton/presentation/pages/tv_show/top_rated_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/tv_show/tv_show_detail_page.dart';
import 'package:ditonton/presentation/pages/tv_show/tv_show_home_page.dart';
import 'package:ditonton/presentation/pages/tv_show/watchlist_tv_shows_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:provider/single_child_widget.dart';

import 'presentation/provider/tv_show/airing_today_tv_shows_notifier.dart';
import 'presentation/provider/tv_show/popular_tv_shows_notifier.dart';
import 'presentation/provider/tv_show/top_rated_tv_shows_notifier.dart';
import 'presentation/provider/tv_show/tv_show_detail_notifier.dart';
import 'presentation/provider/tv_show/tv_show_list_notifier.dart.dart';
import 'presentation/provider/tv_show/tv_show_search_notifier.dart';
import 'presentation/provider/tv_show/watchlist_tv_show_notifier.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var movieProvs = <SingleChildWidget>[
      ChangeNotifierProvider(
        create: (_) => di.locator<MovieListNotifier>(),
      ),
      ChangeNotifierProvider(
        create: (_) => di.locator<MovieDetailNotifier>(),
      ),
      ChangeNotifierProvider(
        create: (_) => di.locator<MovieSearchNotifier>(),
      ),
      ChangeNotifierProvider(
        create: (_) => di.locator<TopRatedMoviesNotifier>(),
      ),
      ChangeNotifierProvider(
        create: (_) => di.locator<PopularMoviesNotifier>(),
      ),
      ChangeNotifierProvider(
        create: (_) => di.locator<WatchlistMovieNotifier>(),
      ),
    ];
    var tvShowProvs = <SingleChildWidget>[
      ChangeNotifierProvider(
        create: (_) => di.locator<TvShowListNotifier>(),
      ),
      ChangeNotifierProvider(
        create: (_) => di.locator<AiringTodayTvShowsNotifier>(),
      ),
      ChangeNotifierProvider(
        create: (_) => di.locator<PopularTvShowsNotifier>(),
      ),
      ChangeNotifierProvider(
        create: (_) => di.locator<TopRatedTvShowsNotifier>(),
      ),
      ChangeNotifierProvider(
        create: (_) => di.locator<TvShowDetailNotifier>(),
      ),
      ChangeNotifierProvider(
        create: (_) => di.locator<TvShowSearchNotifier>(),
      ),
      ChangeNotifierProvider(
        create: (_) => di.locator<WatchlistTvShowNotifier>(),
      ),
    ];

    movieProvs.addAll(tvShowProvs);

    return MultiProvider(
      providers: movieProvs,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: MovieHomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => MovieHomePage());
            case TvShowHomePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TvShowHomePage());
            case AiringTodayTvShowsPage.ROUTE_NAME:
              return CupertinoPageRoute(
                builder: (_) => AiringTodayTvShowsPage(),
              );
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case PopularTvShowsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvShowsPage());
            case TopRatedTvShowsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvShowsPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TvShowDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvShowDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case SearchTvShowPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTvShowPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case WatchlistTvShowsPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTvShowsPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
