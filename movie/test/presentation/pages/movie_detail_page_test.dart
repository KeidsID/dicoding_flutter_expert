import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockBloc extends Mock implements MovieDetailBloc {}

void main() {
  late MockBloc mockBloc;

  setUp(() {
    mockBloc = MockBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Watchlist button should display add icon when movie not added to watchlist',
    (WidgetTester tester) async {
      final blocState = MovieDetailState.init().copyWith(
        blocState: RequestState.loaded,
        movieDetail: dummyMovieDetail,
        recomms: dummyMovieList,
      );

      when(() => mockBloc.stream).thenAnswer((_) => Stream.value(blocState));
      when(() => mockBloc.state).thenReturn(blocState);

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should dispay check icon when movie is added to wathclist',
    (WidgetTester tester) async {
      final blocState = MovieDetailState.init().copyWith(
        blocState: RequestState.loaded,
        movieDetail: dummyMovieDetail,
        recomms: dummyMovieList,
        watchlistStatus: true,
      );

      when(() => mockBloc.stream).thenAnswer((_) => Stream.value(blocState));
      when(() => mockBloc.state).thenReturn(blocState);

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display Snackbar when added to watchlist',
    (WidgetTester tester) async {
      const dummyMsg = 'Added to Watchlist';

      final blocStateBefore = MovieDetailState.init().copyWith(
        blocState: RequestState.loaded,
        movieDetail: dummyMovieDetail,
        recomms: dummyMovieList,
      );
      final blocStateAfter = MovieDetailState.init().copyWith(
        blocState: RequestState.loaded,
        movieDetail: dummyMovieDetail,
        recomms: dummyMovieList,
        watchlistStatus: true,
        watchlistMsg: dummyMsg,
      );

      when(() => mockBloc.stream).thenAnswer(
          (_) => Stream.fromIterable([blocStateBefore, blocStateAfter]));
      when(() => mockBloc.state).thenReturn(blocStateBefore);

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      when(() => mockBloc.state).thenReturn(blocStateAfter);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text(dummyMsg), findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display AlertDialog when add to watchlist failed',
    (WidgetTester tester) async {
      const dummyMsg = 'Failed';

      final blocStateBefore = MovieDetailState.init().copyWith(
        blocState: RequestState.loaded,
        movieDetail: dummyMovieDetail,
        recomms: dummyMovieList,
      );
      final blocStateAfter = MovieDetailState.init().copyWith(
        blocState: RequestState.loaded,
        movieDetail: dummyMovieDetail,
        recomms: dummyMovieList,
        watchlistMsg: dummyMsg,
      );

      when(() => mockBloc.stream).thenAnswer(
          (_) => Stream.fromIterable([blocStateBefore, blocStateAfter]));
      when(() => mockBloc.state).thenReturn(blocStateBefore);

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton, warnIfMissed: false);
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text(dummyMsg), findsOneWidget);
    },
  );
}
