import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ServiceHttpClient {
  final String baseUrl = 'http://10.0.0.2:8000/api/';
  final secureStorage = FlutterSecureStorage();

  //POST
  Future<http.Response> post(String endpoint, {Map<String, dynamic>? body}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    
    try{
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );
      return response;
    }catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }
  //GET
  Future<http.Response> get(String endpoint) async {
    final token = await secureStorage.read(key : 'token');
    final url = Uri.parse('$baseUrl$endpoint');
    
    try{
      final response = await http.post(
        url,
        headers: {
          if (token != null)'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      return response;
    }catch (e) {
      throw Exception('Failed to get data: $e');
    }
  }
  // PUT
  // DELETE
  Future<http.Response> postWithToken(String url, dynamic body) async {
  final token = await secureStorage.read(key: "token");

  return http.post(
    Uri.parse(baseUrl + url),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: body is String ? body : json.encode(body),
  );
}
}