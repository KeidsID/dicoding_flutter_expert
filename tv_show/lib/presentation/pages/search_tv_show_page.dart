import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:core/core.dart';
import '../provider/tv_show_search_notifier.dart';
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
              onSubmitted: (query) => (query != '')
                  ? Provider.of<TvShowSearchNotifier>(
                      context,
                      listen: false,
                    ).fetchSearchResults(query)
                  : ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No Input')),
                    ),
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            Consumer<TvShowSearchNotifier>(
              builder: (context, prov, child) {
                if (prov.state == RequestState.empty) {
                  return Expanded(child: Container());
                }

                if (prov.state == RequestState.loading) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (prov.state == RequestState.error) {
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

                              prov.fetchSearchResults(_searchCtrler.text);
                            },
                            child: const Text('Refresh'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final results = prov.results;

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
                      final tvShow = prov.results[index];
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
