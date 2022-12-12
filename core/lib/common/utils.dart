import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

String readJson(String relativePath) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  return File('$dir/test/$relativePath').readAsStringSync();
}

EventTransformer<T> blocDebounceTime<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
