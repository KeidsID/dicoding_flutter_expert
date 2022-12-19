import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/pages/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_show/presentation/bloc/tv_show_list/tv_show_list_bloc.dart';

import '../../domain/entities/tv_show.dart';
import 'airing_today_tv_shows_page.dart';
import 'popular_tv_shows_page.dart';
import 'search_tv_show_page.dart';
import 'top_rated_tv_shows_page.dart';
import 'tv_show_detail_page.dart';
import 'watchlist_tv_shows_page.dart';

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
      context.read<TvShowListBloc>().add(const OnFetchAiringToday());
      context.read<TvShowListBloc>().add(const OnFetchPopular());
      context.read<TvShowListBloc>().add(const OnFetchTopRated());
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

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
              BlocBuilder<TvShowListBloc, TvShowListState>(
                builder: (context, state) {
                  if (state.atState == RequestState.loading) {
                    return SizedBox(
                      width: screenSize.width,
                      height: 200,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (state.atState != RequestState.loaded) {
                    if (state.atState != RequestState.error) {
                      return const SizedBox();
                    }

                    return SizedBox(
                      width: screenSize.width,
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(state.msg),
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<TvShowListBloc>()
                                    .add(const OnFetchAiringToday());
                              },
                              child: const Text('Refresh'),
                            )
                          ],
                        ),
                      ),
                    );
                  }

                  return TvShowList(state.atResults);
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(context, PopularTvShowsPage.routeName);
                },
              ),
              BlocBuilder<TvShowListBloc, TvShowListState>(
                builder: (context, state) {
                  if (state.popState == RequestState.loading) {
                    return SizedBox(
                      width: screenSize.width,
                      height: 200,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (state.popState != RequestState.loaded) {
                    if (state.popState != RequestState.error) {
                      return const SizedBox();
                    }

                    return SizedBox(
                      width: screenSize.width,
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(state.msg),
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<TvShowListBloc>()
                                    .add(const OnFetchPopular());
                              },
                              child: const Text('Refresh'),
                            )
                          ],
                        ),
                      ),
                    );
                  }

                  return TvShowList(state.popResults);
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () {
                  Navigator.pushNamed(context, TopRatedTvShowsPage.routeName);
                },
              ),
              BlocBuilder<TvShowListBloc, TvShowListState>(
                builder: (context, state) {
                  if (state.trState == RequestState.loading) {
                    return SizedBox(
                      width: screenSize.width,
                      height: 200,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (state.trState != RequestState.loaded) {
                    if (state.trState != RequestState.error) {
                      return const SizedBox();
                    }

                    return SizedBox(
                      width: screenSize.width,
                      height: 200,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(state.msg),
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<TvShowListBloc>()
                                    .add(const OnFetchTopRated());
                              },
                              child: const Text('Refresh'),
                            )
                          ],
                        ),
                      ),
                    );
                  }

                  return TvShowList(state.trResults);
                },
              ),
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
