import 'package:mockito/annotations.dart';

import 'package:movie/presentation/provider/movie_detail_notifier.dart';
import 'package:movie/presentation/provider/popular_movies_notifier.dart';
import 'package:movie/presentation/provider/top_rated_movies_notifier.dart';

@GenerateMocks([
  MovieDetailNotifier,
  PopularMoviesNotifier,
  TopRatedMoviesNotifier,
])
void main() {}
