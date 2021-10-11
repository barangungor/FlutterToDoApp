import 'dart:io';
import 'package:http/http.dart';
import 'package:todoapp/global/global_datas.dart';

class NetworkController {
  Future<String> get(String url) async {
    Uri uri = Uri.parse(url);
    var response = await client.get(uri);
    checkAndThrowError(response);
    return response.body;
  }

  static void checkAndThrowError(Response response) {
    if (response.statusCode != HttpStatus.ok) throw Exception(response.body);
  }
}
