import 'dart:convert';
// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String apiKey = "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";

class ApiServices {
  static String baseUrl = "https://api.openai.com/v1/completions";

  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };

  static sendMessage(String? message) async {
    var res = await http.post(Uri.parse(baseUrl),
        headers: header,
        body: jsonEncode({
          "model": "text-davinci-003",
          // "prompt": "how the weather in seoul",
          "prompt": "$message",
          "temperature": 0,
          "max_tokens": 2048,
          "top_p": 1,
          "frequency_penalty": 0.0,
          "presence_penalty": 0.0,
          "stop": [" Human:", " AI:"]
        }));

    if (res.statusCode == 200) {
      var data = jsonDecode(utf8.decode(res.bodyBytes));
      // var data = jsonDecode(res.body.toString());
      var msg = data['choices'][0]['text'];
      return msg;
    } else {
      print('Failed to fetch data');
      print(res.statusCode);
    }
  }
}
