import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mds_project/models/login_request_model.dart';
import 'package:mds_project/models/register_response_model.dart';
import 'package:mds_project/models/register_request_model.dart';
import 'package:mds_project/models/score_modify_model.dart';
import 'package:mds_project/services/persistancehandler.dart';

import '../models/params_requets_model.dart';
import '../models/score_response_model.dart';
import '../models/user.dart';

class APIService {
  static var client = http.Client();

  static Future<http.Response> login(
    LoginRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    var url = "http://162.19.230.6:5000/api/auth/login";

    http.Response response = await client.post(
      Uri.parse(url),
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    return response;
  }

  static Future<String> register(
    RegisterRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json;charset=UTF-8',
    };
    var url = "http://162.19.230.6:5000/api/auth/register";

    var response = await client.post(
      Uri.parse(url),
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "404";
    }
  }

  Future<String> addOrUpdateScore(
      String userId, String accessToken, ScoreModifyModel model) async {
    try {
      // Send a POST request to the server to add or update the score
      final response = await http.post(
        Uri.parse('http://162.19.230.6:5000/api/scores/$userId/scores'),
        headers: {
          'token': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 201) {
        return ('Score added/updated successfully');
      } else {
        return ('Failed to add/update score: ${response.statusCode}');
      }
    } catch (error) {
      return ('Error adding/updating score: $error');
    }
  }

  Future<http.Response> updateUserParams(
      String username, ParamsModel model) async {
    var accesToken = await PersistanceHandler().getTokenEDP();

    final response = await http.put(
      Uri.parse('http://162.19.230.6:5000/api/users/$username'),
      headers: {
        //  'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(model.toJson()),
    );

    return response;
  }

  Future<http.Response> delUser(String username) async {
    var accesToken = await PersistanceHandler().getTokenEDP();

    final response = await http.delete(
      Uri.parse('http://162.19.230.6:5000/api/rm/$username'),
      headers: {
        //  'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    return response;
  }

  Future<List<ScoreResponseModel>> getScores(
      String userId, String accessToken) async {
    try {
      final response = await http.get(
        Uri.parse('http://162.19.230.6:5000/api/scores/$userId'),
        headers: {
          'token': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonScores = jsonDecode(response.body);
        final List<ScoreResponseModel> scores = jsonScores
            .map((json) => ScoreResponseModel.fromJson(json))
            .toList();
        return scores;
      } else {
        throw Exception('Failed to get scores: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error getting scores: $error');
    }
  }
}
