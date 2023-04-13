import 'package:http/http.dart' as http;
import 'package:tipti_test/app/models/home_models/movie_model.dart';
import 'package:tipti_test/app/models/result_models/result_people_model.dart';
import 'package:tipti_test/app/utils/helper.dart';
import 'dart:convert';

class Repository {
  Future<ResultPeopletModel?> getPeopleApi({String uri = ""}) async {
    final response = await http.get(Uri.parse(getUri(uri: uri)),
        headers: await getHeaders());

    if (response.statusCode == 200) {
      var decodedBody = decodedUtf8(response.body);
      var jsonBody = json.decode(decodedBody);

      return ResultPeopletModel.fromJson(jsonBody);
    } else {
      return null;
    }
  }

  Future<MovieModel?> getMovies({String uri = ""}) async {
    final response =
        await http.get(Uri.parse(uri), headers: await getHeaders());
    if (response.statusCode == 200) {
      var decodedBody = decodedUtf8(response.body);
      var jsonBody = json.decode(decodedBody);

      return MovieModel.fromJson(jsonBody);
    } else {
      return null;
    }
  }
}
