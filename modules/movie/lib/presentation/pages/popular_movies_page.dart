import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:core/common/state_enum.dart';
import '../bloc/popular_movies/popular_movies_bloc.dart';
import '../widgets/movie_card.dart';

class PopularMoviesPage extends StatefulWidget {
  static const routeName = '/popular-movie';

  const PopularMoviesPage({super.key});

  @override
  State<PopularMoviesPage> createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PopularMoviesBloc>().add(const OnFetchingPopularMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
          builder: (context, state) {
            if (state.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.results[index];
                  return MovieCard(movie: movie);
                },
                itemCount: state.results.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(state.msg),
              );
            }
          },
        ),
      ),
    );
  }
}
