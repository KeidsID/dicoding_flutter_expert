import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:core/common/state_enum.dart';
import '../widgets/movie_card.dart';
import '../bloc/top_rated_movies/top_rated_movies_bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const routeName = '/top-rated-movie';

  const TopRatedMoviesPage({super.key});

  @override
  State<TopRatedMoviesPage> createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TopRatedMoviesBloc>().add(const OnFetchingTopRatedMovies());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
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
