import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:core/core.dart';
import 'package:core/pages/about_page.dart';
import 'package:tv_show/presentation/pages/tv_show_home_page.dart';

import '../bloc/movie_list/movie_list_bloc.dart';
import 'movie_detail_page.dart';
import 'popular_movies_page.dart';
import 'search_page.dart';
import 'top_rated_movies_page.dart';
import 'watchlist_movies_page.dart';
import '../../domain/entities/movie.dart';

class MovieHomePage extends StatefulWidget {
  const MovieHomePage({super.key});

  @override
  State<MovieHomePage> createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  @override
  void initState() {
    super.initState();

    context.read<MovieListBloc>().add(OnFetchingNowPlayingMovies());
    context.read<MovieListBloc>().add(OnFetchingPopularMovies());
    context.read<MovieListBloc>().add(OnFetchingTopRatedMovies());
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
              iconColor: kMikadoYellow,
              textColor: kMikadoYellow,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.tv),
              title: const Text('TV Shows'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, TvShowHomePage.routeName);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.routeName);
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
              Navigator.pushNamed(context, SearchPage.routeName);
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
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<MovieListBloc, MovieListState>(
                builder: (context, state) {
                  final bloc = context.read<MovieListBloc>();

                  if (state.npState == RequestState.loading) {
                    return const SizedBox(
                      height: 200,
                      child: Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  }

                  if (state.npState != RequestState.loaded) {
                    return _listError(
                      msg: state.msg,
                      onPressed: () {
                        bloc.add(OnFetchingNowPlayingMovies());
                      },
                    );
                  }

                  return MovieList(state.npResults);
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.routeName),
              ),
              BlocBuilder<MovieListBloc, MovieListState>(
                builder: (context, state) {
                  final bloc = context.read<MovieListBloc>();

                  if (state.popState == RequestState.loading) {
                    return const SizedBox(
                      height: 200,
                      child: Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  }

                  if (state.popState != RequestState.loaded) {
                    return _listError(
                      msg: state.msg,
                      onPressed: () {
                        bloc.add(OnFetchingPopularMovies());
                      },
                    );
                  }

                  return MovieList(state.popResults);
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.routeName),
              ),
              BlocBuilder<MovieListBloc, MovieListState>(
                builder: (context, state) {
                  final bloc = context.read<MovieListBloc>();

                  if (state.trState == RequestState.loading) {
                    return const SizedBox(
                      height: 200,
                      child: Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  }

                  if (state.trState != RequestState.loaded) {
                    return _listError(
                      msg: state.msg,
                      onPressed: () {
                        bloc.add(OnFetchingTopRatedMovies());
                      },
                    );
                  }

                  return MovieList(state.trResults);
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

  Widget _listError({required String msg, required void Function() onPressed}) {
    return SizedBox(
      height: 200,
      child: Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(msg),
              ElevatedButton(
                onPressed: onPressed,
                child: const Text('Refresh'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.routeName,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$kApiBaseImageUrl${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
