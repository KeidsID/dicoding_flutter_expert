import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:core/core.dart';
import 'package:core/pages/about_page.dart';

import 'airing_today_tv_shows_page.dart';
import 'popular_tv_shows_page.dart';
import 'search_tv_show_page.dart';
import 'top_rated_tv_shows_page.dart';
import 'tv_show_detail_page.dart';
import 'watchlist_tv_shows_page.dart';

import '../provider/tv_show_list_notifier.dart.dart';
import '../../domain/entities/tv_show.dart';

class TvShowHomePage extends StatefulWidget {
  static const routeName = '/tv_show_home';

  const TvShowHomePage({super.key});

  @override
  State<TvShowHomePage> createState() => _TvShowHomePageState();
}

class _TvShowHomePageState extends State<TvShowHomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      return Provider.of<TvShowListNotifier>(context, listen: false)
        ..fetchAiringTodayTvShows()
        ..fetchPopularTvShows()
        ..fetchTopRatedTvShows();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Movies'),
              onTap: () {
                // popUntil() did'nt work, so I did this
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('TV Shows'),
              iconColor: kMikadoYellow,
              textColor: kMikadoYellow,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTvShowsPage.routeName);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.routeName);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTvShowPage.routeName);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Airing Today',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AiringTodayTvShowsPage.routeName,
                  );
                },
              ),
              Consumer<TvShowListNotifier>(builder: (context, data, child) {
                final state = data.airingTodayState;
                if (state == RequestState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.loaded) {
                  return TvShowList(data.airingTodayTvShows);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(context, PopularTvShowsPage.routeName);
                },
              ),
              Consumer<TvShowListNotifier>(builder: (context, data, child) {
                final state = data.popularState;
                if (state == RequestState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.loaded) {
                  return TvShowList(data.popularTvShows);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () {
                  Navigator.pushNamed(context, TopRatedTvShowsPage.routeName);
                },
              ),
              Consumer<TvShowListNotifier>(builder: (context, data, child) {
                final state = data.topRatedState;
                if (state == RequestState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.loaded) {
                  return TvShowList(data.topRatedTvShows);
                } else {
                  return const Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvShowList extends StatelessWidget {
  final List<TvShow> tvShows;

  const TvShowList(this.tvShows, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvShow = tvShows[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvShowDetailPage.routeName,
                  arguments: tvShow.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$kApiBaseImageUrl${tvShow.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvShows.length,
      ),
    );
  }
}
