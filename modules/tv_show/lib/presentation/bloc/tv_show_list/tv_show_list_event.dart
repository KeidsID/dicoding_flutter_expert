part of 'tv_show_list_bloc.dart';

abstract class TvShowListEvent {
  const TvShowListEvent();
}

class OnFetchAiringToday extends TvShowListEvent {
  const OnFetchAiringToday();
}

class OnFetchPopular extends TvShowListEvent {
  const OnFetchPopular();
}

class OnFetchTopRated extends TvShowListEvent {
  const OnFetchTopRated();
}
