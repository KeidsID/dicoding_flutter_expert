part of 'tv_show_list_bloc.dart';

class TvShowListState extends Equatable {
  // at -> Airing Today
  // pop -> Popular
  // tr -> Top Rated

  final RequestState atState;
  final RequestState popState;
  final RequestState trState;

  final List<TvShow> atResults;
  final List<TvShow> popResults;
  final List<TvShow> trResults;

  final String msg;

  const TvShowListState({
    required this.atState,
    required this.popState,
    required this.trState,
    required this.atResults,
    required this.popResults,
    required this.trResults,
    required this.msg,
  });

  factory TvShowListState.init() {
    return const TvShowListState(
      atState: RequestState.empty,
      popState: RequestState.empty,
      trState: RequestState.empty,
      atResults: [],
      popResults: [],
      trResults: [],
      msg: '',
    );
  }

  @override
  List<Object> get props {
    return [
      atState,
      popState,
      trState,
      atResults,
      popResults,
      trResults,
      msg,
    ];
  }

  TvShowListState copyWith({
    RequestState? atState,
    RequestState? popState,
    RequestState? trState,
    List<TvShow>? atResults,
    List<TvShow>? popResults,
    List<TvShow>? trResults,
    String? msg,
  }) {
    return TvShowListState(
      atState: atState ?? this.atState,
      popState: popState ?? this.popState,
      trState: trState ?? this.trState,
      atResults: atResults ?? this.atResults,
      popResults: popResults ?? this.popResults,
      trResults: trResults ?? this.trResults,
      msg: msg ?? this.msg,
    );
  }
}
