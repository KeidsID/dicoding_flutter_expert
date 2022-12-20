import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:core/common/utils.dart';
import '../bloc/watchlist_tv_show/watchlist_tv_show_bloc.dart';
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
    Future.microtask(
      () => context
          .read<WatchlistTvShowBloc>()
          .add(const OnFetchWatchlistTvShows()),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTvShowBloc>().add(const OnFetchWatchlistTvShows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvShowBloc, WatchlistTvShowState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is! HasData) {
              if (state is! Error) return const SizedBox();

              return Center(child: Text(state.msg));
            }

            if (state.results.isEmpty) {
              return const Center(
                child: Text('No watchlist tv show yet. Try add some.'),
              );
            }

            return ListView.builder(
              itemBuilder: (context, index) {
                final tvShow = state.results[index];
                return TvShowCard(tvShow);
              },
              itemCount: state.results.length,
            );
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
