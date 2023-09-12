import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/config.dart';
import 'package:frontend/src/features/core/models/gym_model.dart';
import 'package:frontend/src/utils/shared_service.dart';
import 'package:http/http.dart' as http;

final gymService = Provider((ref) => GymService());

class GymService {
  static var client = http.Client();

  Future<List<Gym>?> getGyms() async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.gymAPI);

    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return gymFromJson(data["data"]);
    } else {
      print(response);
      return null;
    }
  }

  Future<bool> joinGym(int gymId) async {
    var loginDetails = await SharedService.loginDetails();
    var token = loginDetails?.data.token.toString();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Include the token in the headers
    };
    var url = Uri.http(Config.apiURL, '${Config.gymJoinAPI}/$gymId');

    var response = await client.post(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // Assuming the response contains a success indicator (e.g., 'success': true)
      if (data.containsKey('data') && data['data'] == true) {
        return true; // Gym joining was successful
      } else {
        return false; // Gym joining failed
      }
    } else {
      print(response);
      return false; // Gym joining failed due to an error
    }
  }
}
