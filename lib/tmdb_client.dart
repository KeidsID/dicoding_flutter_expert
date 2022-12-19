import 'dart:io';

import 'package:flutter/services.dart';

Future<HttpClient> get tmdbHttpClient async {
  final sslCert =
      await rootBundle.load('assets/certificates/tmdb-api-v3.pem');

  final securityContext = SecurityContext(withTrustedRoots: false);

  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());

  return HttpClient(context: securityContext);
}
