import 'package:ditonton/data/models/tv_show_models/tv_show_model.dart';
import 'package:ditonton/data/models/tv_show_models/tv_show_response.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';

final testTvShow = TvShow(
  posterPath: '/vC324sdfcS313vh9QXwijLIHPJp.jpg',
  popularity: 47.432451,
  id: 31917,
  backdropPath: '/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg',
  voteAverage: 5.04,
  overview:
      'Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.',
  genreIds: [18, 9648],
  voteCount: 133,
  name: 'Pretty Little Liars',
  originalName: 'Pretty Little Liars',
);

final testTvShowModel = TvShowModel(
  posterPath: '/vC324sdfcS313vh9QXwijLIHPJp.jpg',
  popularity: 47.432451,
  id: 31917,
  backdropPath: '/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg',
  voteAverage: 5.04,
  overview:
      'Based on the Pretty Little Liars series of young adult novels by Sara Shepard, the series follows the lives of four girls — Spencer, Hanna, Aria, and Emily — whose clique falls apart after the disappearance of their queen bee, Alison. One year later, they begin receiving messages from someone using the name \"A\" who threatens to expose their secrets — including long-hidden ones they thought only Alison knew.',
  genreIds: [18, 9648],
  voteCount: 133,
  name: 'Pretty Little Liars',
  originalName: 'Pretty Little Liars',
);

final testTvShowResponse = TvShowResponse(
  page: 1,
  results: [testTvShowModel],
  totalResults: 1,
  totalPages: 1,
);

final testTvShowDetail = TvShowDetail(
  backdropPath: '/suopoADq0k8YZr4dQXcU6pToj6s.jpg',
  genres: <Genre>[
    Genre(id: 10765, name: 'Sci-Fi & Fantasy'),
    Genre(id: 18, name: 'Drama'),
    Genre(id: 10759, name: 'Action & Adventure'),
    Genre(id: 9648, name: 'Mystery'),
  ],
  id: 1399,
  name: 'Game of Thrones',
  numberOfEpisodes: 73,
  numberOfSeasons: 8,
  originalName: 'Game of Thrones',
  overview:
      "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
  popularity: 369.594,
  posterPath: '/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg',
  voteAverage: 8.3,
  voteCount: 11504,
);
