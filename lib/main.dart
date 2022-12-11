import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:core/core.dart';
import 'package:core/common/utils.dart';
import 'package:core/pages/about_page.dart';
import 'package:movie/movie.dart';
import 'package:tv_show/tv_show.dart';

import 'injection.dart' as di;

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
            case TvShowHomePage.routeName:
              return MaterialPageRoute(builder: (_) => TvShowHomePage());
            case AiringTodayTvShowsPage.routeName:
              return MaterialPageRoute(
                builder: (_) => AiringTodayTvShowsPage(),
              );
            case PopularMoviesPage.routeName:
              return MaterialPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.routeName:
              return MaterialPageRoute(builder: (_) => TopRatedMoviesPage());
            case PopularTvShowsPage.routeName:
              return MaterialPageRoute(builder: (_) => PopularTvShowsPage());
            case TopRatedTvShowsPage.routeName:
              return MaterialPageRoute(builder: (_) => TopRatedTvShowsPage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TvShowDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvShowDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.routeName:
              return MaterialPageRoute(builder: (_) => SearchPage());
            case SearchTvShowPage.routeName:
              return MaterialPageRoute(builder: (_) => SearchTvShowPage());
            case WatchlistMoviesPage.routeName:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case WatchlistTvShowsPage.routeName:
              return MaterialPageRoute(builder: (_) => WatchlistTvShowsPage());
            case AboutPage.routeName:
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
