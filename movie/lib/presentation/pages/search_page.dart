import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:core/common/state_enum.dart';
import 'package:core/styles/app_theme.dart';

import '../widgets/movie_card.dart';
import '../provider/movie_search_notifier.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/movies_search';

  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchCtrler,
              onSubmitted: (query) {
                if (query == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No Input')),
                  );

                  return;
                }

                Provider.of<MovieSearchNotifier>(context, listen: false)
                    .fetchMovieSearch(query);
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            Consumer<MovieSearchNotifier>(
              builder: (context, data, child) {
                if (data.state == RequestState.loading) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (data.state == RequestState.loaded) {
                  final results = data.searchResult;

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
                        final movie = data.searchResult[index];
                        return MovieCard(movie: movie);
                      },
                      itemCount: results.length,
                    ),
                  );
                } else {
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('No Internet Access'),
                          ElevatedButton(
                            onPressed: () {
                              if (_searchCtrler.text == '') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('No Input')),
                                );

                                return;
                              }

                              data.fetchMovieSearch(_searchCtrler.text);
                            },
                            child: const Text('Refresh'),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
