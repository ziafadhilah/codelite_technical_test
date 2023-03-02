// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, avoid_print

import 'package:http/http.dart' as http;

const urlBase = 'https://api.spaceflightnewsapi.net/v3/articles';

class Request {
  late final String url;
  late final dynamic body;

  Request({required this.url, this.body});

  Future<http.Response> get() {
    print(urlBase + url);
    return http.get(Uri.parse(urlBase + url)).timeout(Duration(minutes: 2));
  }
}
