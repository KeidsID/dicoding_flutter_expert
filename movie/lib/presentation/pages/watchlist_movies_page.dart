import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:core/common/state_enum.dart';
import 'package:core/common/utils.dart';

import '../widgets/movie_card.dart';
import '../provider/watchlist_movie_notifier.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const routeName = '/watchlist-movie';

  const WatchlistMoviesPage({super.key});

  @override
  State<WatchlistMoviesPage> createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
            .fetchWatchlistMovies());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<WatchlistMovieNotifier>(
          builder: (context, data, child) {
            if (data.watchlistState == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.watchlistState == RequestState.loaded) {
              if (data.watchlistMovies.isEmpty) {
                return const Center(
                  child: Text('No watchlist movie yet. Try add some.'),
                );
              }

              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.watchlistMovies[index];
                  return MovieCard(movie: movie);
                },
                itemCount: data.watchlistMovies.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
