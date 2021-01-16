import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class APIInfo {
  // API Key
  static const apiKey = "10a15b6afbmshf1733b6167ff7c9p1cb823jsn0c6f059a8c00";

  // Base API Url
  static const baseUrl = "unogsng.p.rapidapi.com";

  // Base headers for Response url
  static const Map<String, String> headers = {
    "content-type": "application/json",
    "x-rapidapi-host": baseUrl,
    "x-rapidapi-key": apiKey,
  };

  // Base API request to get response
  Future<dynamic> get({
    @required String endpoint,
    @required Map<String, String> query,
  }) async {
    Uri uri = Uri.https(baseUrl, endpoint, query);
    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return json.decode(response.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load json data');
    }
  }
}