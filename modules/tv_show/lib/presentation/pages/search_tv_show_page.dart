import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:core/core.dart';
import 'package:tv_show/presentation/bloc/tv_show_search/tv_show_search_bloc.dart';
import '../widgets/tv_show_card.dart';

class SearchTvShowPage extends StatefulWidget {
  const SearchTvShowPage({Key? key}) : super(key: key);

  static const routeName = '/tv_shows_search';

  @override
  State<SearchTvShowPage> createState() => _SearchTvShowPageState();
}

class _SearchTvShowPageState extends State<SearchTvShowPage> {
  late TextEditingController _searchCtrler;

  @override
  void initState() {
    super.initState();
    _searchCtrler = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchCtrler.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<TvShowSearchBloc>().add(const OnDidChangeDep());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchCtrler,
              decoration: const InputDecoration(
                hintText: 'Search Tv Show name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
              onChanged: (value) {
                if (value == '') {
                  context.read<TvShowSearchBloc>().add(const OnEmptyQuery());
                  return;
                }

                context.read<TvShowSearchBloc>().add(OnQueryChanged(value));
              },
            ),
            const SizedBox(height: 16),
            Text('Search Result', style: kHeading6),
            BlocBuilder<TvShowSearchBloc, TvShowSearchState>(
              builder: (context, state) {
                if (state is Loading) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (state is! HasData) {
                  if (state is! Error) return const SizedBox();

                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('No Internet Access'),
                          ElevatedButton(
                            onPressed: () {
                              final query = _searchCtrler.text;

                              if (query == '') {
                                context
                                    .read<TvShowSearchBloc>()
                                    .add(const OnDidChangeDep());
                                return;
                              }

                              context
                                  .read<TvShowSearchBloc>()
                                  .add(OnQueryChanged(query));
                            },
                            child: const Text('Refresh'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final results = state.results;

                if (results.isEmpty) {
                  return const Expanded(
                    child: Center(
                      child: Text('No result for your search. sorry :('),
                    ),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final tvShow = state.results[index];
                      return TvShowCard(tvShow);
                    },
                    itemCount: results.length,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
