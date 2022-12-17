import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:core/core.dart';
import 'package:core/common/utils.dart';
import '../provider/watchlist_tv_show_notifier.dart';
import '../widgets/tv_show_card.dart';

class WatchlistTvShowsPage extends StatefulWidget {
  static const routeName = '/watchlist_tv_show';

  const WatchlistTvShowsPage({super.key});

  @override
  State<WatchlistTvShowsPage> createState() => _WatchlistTvShowsPageState();
}

class _WatchlistTvShowsPageState extends State<WatchlistTvShowsPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistTvShowNotifier>(context, listen: false)
            .fetchTvShows());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<WatchlistTvShowNotifier>(context, listen: false).fetchTvShows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<WatchlistTvShowNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              if (data.results.isEmpty) {
                return const Center(
                  child: Text('No watchlist tv show yet. Try add some.'),
                );
              }

              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = data.results[index];
                  return TvShowCard(tvShow);
                },
                itemCount: data.results.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.msg),
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
