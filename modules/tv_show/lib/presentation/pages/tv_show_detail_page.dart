import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/entities/genre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../domain/entities/tv_show.dart';
import '../../domain/entities/tv_show_detail.dart';
import '../bloc/tv_show_detail/tv_show_detail_bloc.dart';

class TvShowDetailPage extends StatefulWidget {
  const TvShowDetailPage({Key? key, required this.id}) : super(key: key);

  final int id;

  static const routeName = 'tv_show_detail';

  @override
  State<TvShowDetailPage> createState() => _TvShowDetailPageState();
}

class _TvShowDetailPageState extends State<TvShowDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvShowDetailBloc>().add(OnFetchDetail(widget.id));
      context.read<TvShowDetailBloc>().add(OnLoadDbStatus(widget.id));
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<TvShowDetailBloc>().add(const OnDidChangeDep());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TvShowDetailBloc, TvShowDetailState>(
        builder: (context, state) {
          if (state.blocState == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.blocState != RequestState.loaded) {
            if (state.blocState != RequestState.error) return const SizedBox();

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.blocStateMsg),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<TvShowDetailBloc>()
                          .add(OnFetchDetail(widget.id));
                    },
                    child: const Text('Refresh'),
                  ),
                ],
              ),
            );
          }

          return SafeArea(
            child: TvShowDetailContent(
              detail: state.tvShowDetail!,
              recomms: state.recomms,
              isWatchlisted: state.watchlistStatus,
            ),
          );
        },
        listener: (context, state) {
          final msg = state.watchlistMsg;
          final bool1 = msg == TvShowDetailBloc.addToDbSuccessMsg;
          final bool2 = msg == TvShowDetailBloc.removeFromDbSuccessMsg;

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

class TvShowDetailContent extends StatelessWidget {
  final TvShowDetail detail;
  final List<TvShow> recomms;
  final bool isWatchlisted;

  const TvShowDetailContent({
    Key? key,
    required this.detail,
    required this.recomms,
    required this.isWatchlisted,
  }) : super(key: key);

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
        _content(),
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
        ),
      ],
    );
  }

  Widget _content() {
    return Container(
      margin: const EdgeInsets.only(top: 48 + 8),
      child: DraggableScrollableSheet(
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.only(
              left: 16,
              top: 16,
              right: 16,
            ),
            decoration: const BoxDecoration(
              color: kRichBlack,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
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
                        Text(detail.name, style: kHeading5),
                        ElevatedButton(
                          onPressed: () {
                            if (isWatchlisted) {
                              context
                                  .read<TvShowDetailBloc>()
                                  .add(OnRemoveFromDb(detail));
                              return;
                            }

                            context
                                .read<TvShowDetailBloc>()
                                .add(OnAddToDb(detail));
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              isWatchlisted
                                  ? const Icon(Icons.check)
                                  : const Icon(Icons.add),
                              const SizedBox(width: 8),
                              const Text('Watchlist'),
                            ],
                          ),
                        ),
                        Text(_showGenres(detail.genres)),
                        Row(
                          children: [
                            RatingBarIndicator(
                              itemBuilder: (context, index) {
                                return const Icon(
                                  Icons.star,
                                  color: kMikadoYellow,
                                );
                              },
                              itemSize: 24,
                              rating: detail.voteAverage / 2,
                            ),
                            Text('${detail.voteAverage}'),
                          ],
                        ),
                        Text('Total Episodes: ${detail.numberOfEpisodes}'),
                        Text('Total Seasons: ${detail.numberOfSeasons}'),
                        const SizedBox(height: 16),
                        Text('Overview', style: kHeading6),
                        Text(detail.overview),
                        const SizedBox(height: 16),
                        Text('Recommendations', style: kHeading6),
                        _recommendations(),
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
      ),
    );
  }

  Widget _recommendations() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recomms.length,
        itemBuilder: (context, index) {
          final recomm = recomms[index];
          return Padding(
            padding: const EdgeInsets.all(4),
            child: InkWell(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: '$kApiBaseImageUrl${recomm.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  TvShowDetailPage.routeName,
                  arguments: recomm.id,
                );
              },
            ),
          );
        },
      ),
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
}
