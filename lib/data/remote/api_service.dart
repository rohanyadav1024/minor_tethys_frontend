import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api_interface.dart';

class ApiService extends ApiInterface {
  @override
  Future post(url, data) async {
    final client = http.Client();
    http.Response response = await client.post(
      Uri.parse(ApiInterface.baseUrl + url),
      body: jsonEncode(data),
      headers: {"Content-Type": "Application/json"},
    );
    debugPrint('post rsponse: ${response.body}');
    return response.body;
  }

  @override
  Future put(url, data) async {
    final client = http.Client();

    debugPrint(jsonEncode(data).toString());
    http.Response response = await client.put(
      Uri.parse(ApiInterface.baseUrl + url),
      body: jsonEncode(data),
      headers: {"Content-Type": "Application/json"},
    );
    debugPrint('put response: ${response.body}');
    return response.body;
  }

  @override
  Future get(url) async {
    final client = http.Client();
    http.Response response = await client.get(
      Uri.parse(ApiInterface.baseUrl + url),
      headers: {"Content-Type": "Application/json"},
    );
    debugPrint('get response: ${response.body}');
    return response.body;
  }

  @override
  Future delete(url, data) async {
    final client = http.Client();
    debugPrint('delte api callled');
    http.Response response = await client.delete(
      Uri.parse(ApiInterface.baseUrl + url),
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );
    debugPrint('delete rsponse: ${response.body}');
    return response.body;
  }
}
