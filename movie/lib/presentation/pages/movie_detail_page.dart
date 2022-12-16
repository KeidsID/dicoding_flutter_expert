import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/entities/genre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';

import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';

class MovieDetailPage extends StatefulWidget {
  static const routeName = '/movie_detail';

  const MovieDetailPage({super.key, required this.id});

  final int id;

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieDetailBloc>().add(OnFetchDetail(widget.id));
      context.read<MovieDetailBloc>().add(OnLoadDbStatus(widget.id));
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<MovieDetailBloc>().add(const OnDidChangeDep());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state.blocState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.blocState == RequestState.loaded) {
            return SafeArea(
              child: DetailContent(
                detail: state.movieDetail!,
                recomms: state.recomms,
                isAddedWatchlist: state.watchlistStatus,
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.blocStateMsg),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<MovieDetailBloc>()
                          .add(OnFetchDetail(widget.id));
                    },
                    child: const Text('Refresh'),
                  )
                ],
              ),
            );
          }
        },
        listener: (context, state) {
          final msg = state.watchlistMsg;
          final bool1 = msg == MovieDetailBloc.successAddToDbMsg;
          final bool2 = msg == MovieDetailBloc.successRemoveFromDbMsg;

          if (bool1 || bool2) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(msg)));
          } else if (msg != '') {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(msg),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    )
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail detail;
  final List<Movie> recomms;
  final bool isAddedWatchlist;

  const DetailContent({
    super.key,
    required this.detail,
    required this.recomms,
    required this.isAddedWatchlist,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$kApiBaseImageUrl${detail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(detail.title, style: kHeading5),
                            ElevatedButton(
                              onPressed: () {
                                if (isAddedWatchlist) {
                                  context
                                      .read<MovieDetailBloc>()
                                      .add(OnRemoveFromDb(detail));
                                  return;
                                }

                                context
                                    .read<MovieDetailBloc>()
                                    .add(OnAddToDb(detail));
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const SizedBox(width: 8),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(_showGenres(detail.genres)),
                            Text(_showDuration(detail.runtime)),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: detail.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${detail.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text('Overview', style: kHeading6),
                            Text(detail.overview),
                            const SizedBox(height: 16),
                            Text('Recommendations', style: kHeading6),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final movie = recomms[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          MovieDetailPage.routeName,
                                          arguments: movie.id,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: recomms.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
