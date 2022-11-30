import 'package:ditonton/presentation/widgets/tv_show_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants.dart';
import '../../../common/state_enum.dart';
import '../../provider/tv_show/tv_show_search_notifier.dart';

class SearchTvShowPage extends StatefulWidget {
  const SearchTvShowPage({Key? key}) : super(key: key);

  static const ROUTE_NAME = '/tv_shows_search';

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
      appBar: AppBar(title: Text('Search')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchCtrler,
              decoration: InputDecoration(
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
                  : {},
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            Consumer<TvShowSearchNotifier>(
              builder: (context, prov, child) {
                if (prov.state == RequestState.Empty) {
                  return Expanded(child: Container());
                }

                if (prov.state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (prov.state == RequestState.Error) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('No Internet Access'),
                          ElevatedButton(
                            onPressed: () {
                              prov.fetchSearchResults(_searchCtrler.text);
                            },
                            child: Text('Refresh'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final results = prov.results;

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
