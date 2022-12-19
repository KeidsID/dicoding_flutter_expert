import 'package:core/models/genre_model.dart';
import 'package:core/entities/genre.dart';

import 'package:tv_show/data/models/tv_show_detail_model.dart';
import 'package:tv_show/data/models/tv_show_model.dart';
import 'package:tv_show/data/models/tv_show_response.dart';
import 'package:tv_show/data/models/tv_show_table.dart';
import 'package:tv_show/domain/entities/tv_show.dart';
import 'package:tv_show/domain/entities/tv_show_detail.dart';

final dummyTvShow = TvShow(
  posterPath: '/vC324sdfcS313vh9QXwijLIHPJp.jpg',
  popularity: 47.432451,
  id: 31917,
  backdropPath: '/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg',
  voteAverage: 5.04,
  overview: 'Overview.',
  genreIds: const [18, 9648],
  voteCount: 133,
  name: 'Pretty Little Liars',
  originalName: 'Pretty Little Liars',
);

const dummyTvShowModel = TvShowModel(
  posterPath: '/vC324sdfcS313vh9QXwijLIHPJp.jpg',
  popularity: 47.432451,
  id: 31917,
  backdropPath: '/rQGBjWNveVeF8f2PGRtS85w9o9r.jpg',
  voteAverage: 5.04,
  overview: 'Overview.',
  genreIds: [18, 9648],
  voteCount: 133,
  name: 'Pretty Little Liars',
  originalName: 'Pretty Little Liars',
);

const dummyTvShowResponse = TvShowResponse(
  page: 1,
  results: [dummyTvShowModel],
  totalResults: 1,
  totalPages: 1,
);

const dummyTvShowDetail = TvShowDetail(
  backdropPath: '/suopoADq0k8YZr4dQXcU6pToj6s.jpg',
  genres: [Genre(id: 10765, name: 'Sci-Fi & Fantasy')],
  id: 1399,
  name: 'Game of Thrones',
  numberOfEpisodes: 73,
  numberOfSeasons: 8,
  originalName: 'Game of Thrones',
  overview: "Overview.",
  popularity: 369.594,
  posterPath: '/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg',
  voteAverage: 8.3,
  voteCount: 11504,
);

const dummyTvShowDetailModel = TvShowDetailModel(
  backdropPath: '/suopoADq0k8YZr4dQXcU6pToj6s.jpg',
  genres: [GenreModel(id: 10765, name: 'Sci-Fi & Fantasy')],
  homepage: 'http://www.hbo.com/game-of-thrones',
  id: 1399,
  name: 'Game of Thrones',
  numberOfEpisodes: 73,
  numberOfSeasons: 8,
  originalName: 'Game of Thrones',
  overview: "Overview.",
  popularity: 369.594,
  posterPath: '/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg',
  voteAverage: 8.3,
  voteCount: 11504,
);

final dummyTvMap = {
  'id': 31917,
  'name': 'Pretty Little Liars',
  'overview': 'Overview.',
  'posterPath': '/vC324sdfcS313vh9QXwijLIHPJp.jpg',
};

const dummyTvTable = TvShowTable(
  id: 31917,
  name: 'Pretty Little Liars',
  overview: 'Overview.',
  posterPath: '/vC324sdfcS313vh9QXwijLIHPJp.jpg',
);

final dummyTvShowFromDb = dummyTvTable.toEntity();

const dummyTvShowDetailForDbTest = TvShowDetail(
  backdropPath: '/',
  genres: [],
  id: 31917,
  name: 'Pretty Little Liars',
  numberOfEpisodes: 1,
  numberOfSeasons: 0,
  originalName: 'Pretty Little Liars',
  overview: 'Overview.',
  popularity: 2.5,
  posterPath: '/vC324sdfcS313vh9QXwijLIHPJp.jpg',
  voteAverage: 2.5,
  voteCount: 10,
);
