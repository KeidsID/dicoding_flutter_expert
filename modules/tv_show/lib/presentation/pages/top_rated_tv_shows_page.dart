import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/top_rated_tv_shows/top_rated_tv_shows_bloc.dart';
import '../widgets/tv_show_card.dart';

class TopRatedTvShowsPage extends StatefulWidget {
  static const routeName = '/top_rated_tv_shows';

  const TopRatedTvShowsPage({super.key});

  @override
  State<TopRatedTvShowsPage> createState() => _TopRatedTvShowsPageState();
}

class _TopRatedTvShowsPageState extends State<TopRatedTvShowsPage> {
  late TextEditingController _pageInput;

  String _currentPage = '1';

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TopRatedTvShowsBloc>().add(const OnFetchTvShows()),
    );

    _pageInput = TextEditingController(text: _currentPage);
  }

  @override
  void dispose() {
    super.dispose();
    _pageInput.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top Rated Tv Shows')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvShowsBloc, TopRatedTvShowsState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is! HasData) {
              if (state is! Error) return const SizedBox();

              return Center(
                child: Column(
                  children: [
                    Text(state.msg),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<TopRatedTvShowsBloc>()
                            .add(OnFetchTvShows(page: int.parse(_currentPage)));
                      },
                      child: const Text('Refresh'),
                    )
                  ],
                ),
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
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        height: kToolbarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Page'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 75,
                height: kToolbarHeight - (kToolbarHeight / 4),
                child: TextField(
                  controller: _pageInput,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kMikadoYellow,
                        width: 2,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: kDavysGrey),
                    ),
                  ),
                  onSubmitted: (value) {
                    if ((int.tryParse(value) ?? 0) <= 0 || value == '') {
                      _pageInput.text = _currentPage;
                      return;
                    }

                    setState(() {
                      _currentPage = _pageInput.text;
                    });

                    context
                        .read<TopRatedTvShowsBloc>()
                        .add(OnFetchTvShows(page: int.parse(value)));
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                if (int.parse(_currentPage) - 1 <= 0) {
                  return;
                }

                setState(() {
                  _currentPage = (int.parse(_currentPage) - 1).toString();
                });

                _pageInput.text = _currentPage.toString();

                context
                    .read<TopRatedTvShowsBloc>()
                    .add(OnFetchTvShows(page: int.parse(_currentPage)));
              },
              child: const Icon(Icons.remove),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentPage = (int.parse(_currentPage) + 1).toString();
                });

                _pageInput.text = _currentPage.toString();

                context
                    .read<TopRatedTvShowsBloc>()
                    .add(OnFetchTvShows(page: int.parse(_currentPage)));
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
