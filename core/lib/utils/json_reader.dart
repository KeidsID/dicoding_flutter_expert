import 'dart:io';

String readJson(String relativePath) {
  var dir = Directory.current.path;
  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }
  return File('$dir/test/$relativePath').readAsStringSync();
}
