import 'dart:convert';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

//String? token;
const String baseurl = 'https://capsule-congress-laurel.ngrok-free.dev/api/';
const String imgURL = 'http://172.20.10.3:8000';

class HttpHelper {
  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    final box = GetStorage();
    final storedToken = box.read<String>('token');
    final response =  await http.post(
      Uri.parse('$baseurl$url'),
      body: body,
      headers: {
        'Accept': 'application/json',
        if (storedToken != null) 'Authorization': 'Bearer $storedToken',
      },
    );
    _handleUnauthorized(response);
    return response;
  }
  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    final box = GetStorage();
    final storedToken = box.read<String>('token');
    final response = await http.put(
      Uri.parse('$baseurl$url'),
      body: body,
      headers: {
        'Accept': 'application/json',
        if (storedToken != null) 'Authorization': 'Bearer $storedToken',
      },
    );
    _handleUnauthorized(response);
    return response;
  }
  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    final box = GetStorage();
    final storedToken = box.read<String>('token');

    final response = await http.delete(
      Uri.parse('$baseurl$url'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (storedToken != null)
          'Authorization': 'Bearer $storedToken',
      },
      body: jsonEncode(body),
    );
    _handleUnauthorized(response);
    return response;
  }

  static Future<Response> gettData({required String url}) async {
    final box = GetStorage();
    final storedToken = box.read<String>('token');
    final token = box.read('token') ?? '';
    print('[DEBUG] Sending POST request to: $url');
    print('[DEBUG] Token used: $token');
    final response = await http.get(
      Uri.parse('$baseurl$url'),
      headers: {
        if (storedToken != null) 'Authorization': 'Bearer $storedToken',
      },
    );
    _handleUnauthorized(response);
    return response;
  }

  getData(String url) async {
    try {
      var response = await http.get(Uri.parse('$baseurl$url'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      }
      else {
        print('error ${response.statusCode}');
      }
    } catch (e) {
      print('error catch $e');
    }
  }
  static void _handleUnauthorized(Response response) {
    if (response.statusCode == 401 || response.statusCode == 403) {
      final box = GetStorage();
      box.remove('token');
      box.remove('id');
      box.remove('name');
      Get.offAllNamed('/signIn');
    }
  }
}
