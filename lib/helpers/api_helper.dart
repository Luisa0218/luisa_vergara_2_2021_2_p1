import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter, unused_import
import 'package:elephant_app/helpers/constans.dart';
import 'package:http/http.dart' as http;

import 'package:elephant_app/models/elephant.dart';
import 'package:elephant_app/models/response.dart';

class ApiHelper {
  static Future<Response> getElephants() async {
    var url = Uri.parse('${Constans.apiUrl}/elephants');
    var response = await http.get(url);

    var body = response.body;
    if (response.statusCode >= 400) {
      return Response(isSuccess: false, message: body);
    }

    List<Elephant> list = [];
    var decodeJson = jsonDecode(body);
    if (decodeJson != null) {
      for (var item in decodeJson) {
        list.add(Elephant.fromJson(item));
      }
    }
    return Response(isSuccess: true, result: list);
  }
}
