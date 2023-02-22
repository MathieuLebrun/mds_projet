import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mds_project/models/login_request_model.dart';
import 'package:mds_project/models/login_response_model.dart';
import 'package:mds_project/models/register_response_model.dart';
import 'package:mds_project/models/register_request_model.dart';
import '../../config.dart';
import 'shared_service.dart';
import '../models/user.dart';

class APIService {
  static var client = http.Client();

  static Future<String> login(
    LoginRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    var url = "http://10.0.2.2:5000/api/auth/login";

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

  static Future<RegisterResponseModel> register(
    RegisterRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      "http://mdsproject.test/api/users",
    );
    print(url);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return registerResponseJson(
      response.body,
    );
  }

  static Future<String> getUserProfile() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data.accesToken}'
    };

    var url = Uri.http(Config.apiUrl, Config.userProfileApi);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }
}
