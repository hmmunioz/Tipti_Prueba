import 'dart:convert' show utf8;

Future<Map<String, String>> getHeaders() async {
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

  return headers;
}

String decodedUtf8(String text) {
  try {
    return utf8.decode(text.runes.toList()).toString();
  } catch (e) {
    return text;
  }
}

String getUri({String uri = ""}) {
  String basePeopleUrl = 'https://swapi.dev/api/people';
  return uri == "" ? basePeopleUrl : uri;
}
