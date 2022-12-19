part of 'tv_show_detail_bloc.dart';

class TvShowDetailState extends Equatable {
  final RequestState blocState;

  final TvShowDetail? tvShowDetail;
  final List<TvShow> recomms;
  final bool watchlistStatus;

  final String blocStateMsg;
  final String watchlistMsg;

  const TvShowDetailState({
    required this.blocState,
    this.tvShowDetail,
    required this.recomms,
    required this.watchlistStatus,
    required this.blocStateMsg,
    required this.watchlistMsg,
  });

  factory TvShowDetailState.init() {
    return const TvShowDetailState(
      blocState: RequestState.empty,
      tvShowDetail: null,
      recomms: [],
      watchlistStatus: false,
      blocStateMsg: '',
      watchlistMsg: '',
    );
  }

  @override
  List<Object?> get props {
    return [
      blocState,
      tvShowDetail,
      recomms,
      watchlistStatus,
      blocStateMsg,
      watchlistMsg,
    ];
  }

  TvShowDetailState copyWith({
    RequestState? blocState,
    TvShowDetail? tvShowDetail,
    List<TvShow>? recomms,
    bool? watchlistStatus,
    String? blocStateMsg,
    String? watchlistMsg,
  }) {
    return TvShowDetailState(
      blocState: blocState ?? this.blocState,
      tvShowDetail: tvShowDetail ?? this.tvShowDetail,
      recomms: recomms ?? this.recomms,
      watchlistStatus: watchlistStatus ?? this.watchlistStatus,
      blocStateMsg: blocStateMsg ?? this.blocStateMsg,
      watchlistMsg: watchlistMsg ?? this.watchlistMsg,
    );
  }
}
