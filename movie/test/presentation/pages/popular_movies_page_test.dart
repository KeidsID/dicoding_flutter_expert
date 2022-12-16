import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockBloc extends Mock implements PopularMoviesBloc {}

void main() {
  late MockBloc mockBloc;

  setUp(() {
    mockBloc = MockBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Page should display center progress bar when loading',
    (WidgetTester tester) async {
      when(() => mockBloc.stream).thenAnswer((_) => Stream.value(
          PopularMoviesState.init().copyWith(state: RequestState.loading)));
      when(() => mockBloc.state).thenReturn(
        PopularMoviesState.init().copyWith(state: RequestState.loading),
      );

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display ListView when data is loaded',
    (WidgetTester tester) async {
      when(() => mockBloc.stream).thenAnswer(
        (_) => Stream.value(PopularMoviesState.init().copyWith(
          state: RequestState.loaded,
          results: dummyMovieList,
        )),
      );
      when(() => mockBloc.state).thenReturn(
        PopularMoviesState.init().copyWith(
          state: RequestState.loaded,
          results: dummyMovieList,
        ),
      );

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display text with message when Error',
    (WidgetTester tester) async {
      const dummyFailMsg = 'Fail to Fetch Data';

      when(() => mockBloc.stream).thenAnswer(
        (_) => Stream.value(PopularMoviesState.init().copyWith(
          state: RequestState.error,
          msg: dummyFailMsg,
        )),
      );
      when(() => mockBloc.state).thenReturn(
        PopularMoviesState.init().copyWith(
          state: RequestState.error,
          msg: dummyFailMsg,
        ),
      );

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
