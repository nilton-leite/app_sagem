import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/logging_interceptor.dart';

final Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
    requestTimeout: Duration(seconds: 15));

const String baseUrl = 'https://1907f789d3bf.ngrok.io/services';
