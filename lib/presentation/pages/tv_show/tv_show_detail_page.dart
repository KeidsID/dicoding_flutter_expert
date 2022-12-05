import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../common/constants.dart';
import '../../../common/state_enum.dart';
import '../../../domain/entities/genre.dart';
import '../../../domain/entities/tv_show.dart';
import '../../../domain/entities/tv_show_detail.dart';
import '../../provider/tv_show/tv_show_detail_notifier.dart';

class TvShowDetailPage extends StatefulWidget {
  const TvShowDetailPage({Key? key, required this.id}) : super(key: key);

  final int id;

  static const ROUTE_NAME = 'tv_show_detail';

  @override
  State<TvShowDetailPage> createState() => _TvShowDetailPageState();
}

class _TvShowDetailPageState extends State<TvShowDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      return Provider.of<TvShowDetailNotifier>(context, listen: false)
        ..fetchDetail(widget.id)
        ..loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvShowDetailNotifier>(
        builder: (context, prov, child) {
          if (prov.detailState == RequestState.Loading) {
            return child!;
          }

          if (!(prov.detailState == RequestState.Loaded)) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(prov.detailMsg),
                  ElevatedButton(
                    onPressed: () {
                      prov.fetchDetail(widget.id);
                    },
                    child: Text('Refresh'),
                  ),
                ],
              ),
            );
          }

          final tvShow = prov.detailResult;

          return SafeArea(
            child: TvShowDetailContent(
              tvShow: tvShow,
              recomms: prov.recommResults,
              isWatchlisted: prov.isWatchlisted,
            ),
          );
        },
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class TvShowDetailContent extends StatelessWidget {
  const TvShowDetailContent({
    Key? key,
    required this.tvShow,
    required this.recomms,
    required this.isWatchlisted,
  }) : super(key: key);

  final TvShowDetail tvShow;
  final List<TvShow> recomms;
  final bool isWatchlisted;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$BASE_IMAGE_URL${tvShow.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        _content(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
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
            decoration: BoxDecoration(
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
                        Text(tvShow.name, style: kHeading5),
                        ElevatedButton(
                          onPressed: () async {
                            if (isWatchlisted) {
                              await Provider.of<TvShowDetailNotifier>(
                                context,
                                listen: false,
                              ).deleteFromWatchlist(tvShow);
                            } else {
                              await Provider.of<TvShowDetailNotifier>(
                                context,
                                listen: false,
                              ).addToWatchlist(tvShow);
                            }

                            final msg = await Provider.of<TvShowDetailNotifier>(
                              context,
                              listen: false,
                            ).watchlistMsg;
                            final bool1 = msg ==
                                TvShowDetailNotifier.addWatchlistSuccessMsg;
                            final bool2 = msg ==
                                TvShowDetailNotifier.removeWatchlistSuccessMsg;

                            if (bool1 || bool2) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(msg)),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(content: Text(msg));
                                },
                              );
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              isWatchlisted
                                  ? Icon(Icons.check)
                                  : Icon(Icons.add),
                              Text('Watchlist')
                            ],
                          ),
                        ),
                        Text(_showGenres(tvShow.genres)),
                        Row(
                          children: [
                            RatingBarIndicator(
                              itemBuilder: (context, index) {
                                return Icon(
                                  Icons.star,
                                  color: kMikadoYellow,
                                );
                              },
                              itemSize: 24,
                              rating: tvShow.voteAverage / 2,
                            ),
                            Text('${tvShow.voteAverage}'),
                          ],
                        ),
                        Text('Total Episodes: ${tvShow.numberOfEpisodes}'),
                        Text('Total Seasons: ${tvShow.numberOfSeasons}'),
                        SizedBox(height: 16),
                        Text('Overview', style: kHeading6),
                        Text(tvShow.overview),
                        SizedBox(height: 16),
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
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recomms.length,
        itemBuilder: (context, index) {
          final recomm = recomms[index];
          return Padding(
            padding: EdgeInsets.all(4),
            child: InkWell(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${recomm.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  TvShowDetailPage.ROUTE_NAME,
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
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
