const dummyMovieJson = '''
{
  "adult": false,
  "backdrop_path": "/path.jpg",
  "genre_ids": [ 1, 2, 3, 4 ],
  "id": 1,
  "original_language": "en",
  "original_title": "Original Title",
  "overview": "Overview",
  "popularity": 1.0,
  "poster_path": "/path.jpg",
  "release_date": "2020-05-05",
  "title": "Title",
  "video": false,
  "vote_average": 1.0,
  "vote_count": 1
}
''';

const dummyMovieListJson = '''
{
  "page": 1,
  "results": [$dummyMovieJson],
  "dates": {
    "maximum": "2016-09-01",
    "minimum": "2016-07-21"
  },
  "total_pages": 1,
  "total_results": 1
}
''';

const dummyMovieDetailJson = '''
{
  "adult": false,
  "backdrop_path": "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg",
  "belongs_to_collection": null,
  "budget": 63000000,
  "genres": [
    {
      "id": 18,
      "name": "Drama"
    }
  ],
  "homepage": "",
  "id": 550,
  "imdb_id": "tt0137523",
  "original_language": "en",
  "original_title": "Fight Club",
  "overview": "Overview.",
  "popularity": 0.5,
  "poster_path": null,
  "production_companies": [
    {
      "id": 508,
      "logo_path": "/7PzJdsLGlR7oW4J0J5Xcd0pHGRg.png",
      "name": "Regency Enterprises",
      "origin_country": "US"
    }
  ],
  "production_countries": [
    {
      "iso_3166_1": "US",
      "name": "United States of America"
    }
  ],
  "release_date": "1999-10-12",
  "revenue": 100853753,
  "runtime": 139,
  "spoken_languages": [
    {
      "iso_639_1": "en",
      "name": "English"
    }
  ],
  "status": "Released",
  "tagline": "How much can you know about yourself if you've never been in a fight?",
  "title": "Fight Club",
  "video": false,
  "vote_average": 7.8,
  "vote_count": 3439
}
''';
