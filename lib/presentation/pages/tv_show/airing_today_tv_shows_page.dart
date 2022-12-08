import 'package:ditonton/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/state_enum.dart';
import '../../provider/tv_show/airing_today_tv_shows_notifier.dart';
import '../../widgets/tv_show_card.dart';

class AiringTodayTvShowsPage extends StatefulWidget {
  static const ROUTE_NAME = '/airing_today_tv_shows';

  @override
  _AiringTodayTvShowsPageState createState() => _AiringTodayTvShowsPageState();
}

class _AiringTodayTvShowsPageState extends State<AiringTodayTvShowsPage> {
  late TextEditingController _pageInput;

  String _currentPage = '1';

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<AiringTodayTvShowsNotifier>(context, listen: false)
            .fetchTvShows());

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
      appBar: AppBar(
        title: Text('Airing Today Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<AiringTodayTvShowsNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = data.result[index];
                  return TvShowCard(tvShow);
                },
                itemCount: data.result.length,
              );
            } else {
              return data.msg == ''
                  ? Center(
                      key: Key('error_message'),
                      child: Text('Page Not Found, try another page.'),
                    )
                  : Center(
                      key: Key('error_message'),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(data.msg),
                          ElevatedButton(
                            onPressed: () {
                              data.fetchTvShows(page: int.parse(_currentPage));
                            },
                            child: Text('Refresh'),
                          ),
                        ],
                      ),
                    );
            }
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        height: kToolbarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Page'),
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

                    Provider.of<AiringTodayTvShowsNotifier>(
                      context,
                      listen: false,
                    ).fetchTvShows(page: int.parse(_currentPage));
                  },
                ),
              ),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                if (int.parse(_currentPage) - 1 <= 0) {
                  return;
                }

                setState(() {
                  _currentPage = (int.parse(_currentPage) - 1).toString();
                });

                _pageInput.text = _currentPage.toString();

                Provider.of<AiringTodayTvShowsNotifier>(
                  context,
                  listen: false,
                ).fetchTvShows(page: int.parse(_currentPage));
              },
              child: Icon(Icons.remove),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentPage = (int.parse(_currentPage) + 1).toString();
                });

                _pageInput.text = _currentPage.toString();

                Provider.of<AiringTodayTvShowsNotifier>(
                  context,
                  listen: false,
                ).fetchTvShows(page: int.parse(_currentPage));
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}