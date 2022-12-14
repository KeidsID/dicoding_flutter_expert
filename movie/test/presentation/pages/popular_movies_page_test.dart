import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:core/common/state_enum.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockPopularMoviesBloc extends Mock implements PopularMoviesBloc {}

class FakePopularMoviesState extends Fake implements PopularMoviesState {}

void main() {
  late MockPopularMoviesBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(FakePopularMoviesState());
  });

  setUp(() {
    mockBloc = MockPopularMoviesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Page should display center progress bar when loading',
    (WidgetTester tester) async {
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
      when(() => mockBloc.state).thenReturn(
        PopularMoviesState.init().copyWith(
          state: RequestState.error,
          msg: 'Fail',
        ),
      );

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
