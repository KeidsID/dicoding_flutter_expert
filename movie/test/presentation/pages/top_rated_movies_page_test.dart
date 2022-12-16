import 'package:core/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockBloc extends Mock implements TopRatedMoviesBloc {}

void main() {
  late MockBloc mockBloc;

  setUp(() {
    mockBloc = MockBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Page should display progress bar when loading',
    (WidgetTester tester) async {
      when(() => mockBloc.stream).thenAnswer((_) => Stream.value(
          TopRatedMoviesState.init().copyWith(state: RequestState.loading)));
      when(() => mockBloc.state).thenReturn(
          TopRatedMoviesState.init().copyWith(state: RequestState.loading));

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display when data is loaded',
    (WidgetTester tester) async {
      when(() => mockBloc.stream).thenAnswer(
        (_) => Stream.value(TopRatedMoviesState.init().copyWith(
          state: RequestState.loaded,
          results: dummyMovieList,
        )),
      );
      when(() => mockBloc.state).thenReturn(TopRatedMoviesState.init().copyWith(
        state: RequestState.loaded,
        results: dummyMovieList,
      ));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    'Page should display text with message when Error',
    (WidgetTester tester) async {
      const dummyFailMsg = 'Fail to Fetch Data';

      when(() => mockBloc.stream).thenAnswer(
        (_) => Stream.value(TopRatedMoviesState.init().copyWith(
          state: RequestState.error,
          msg: dummyFailMsg,
        )),
      );
      when(() => mockBloc.state).thenReturn(TopRatedMoviesState.init().copyWith(
        state: RequestState.error,
        msg: dummyFailMsg,
      ));

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
