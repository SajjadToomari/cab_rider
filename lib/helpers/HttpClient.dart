import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpClientResponse {
  final int _status;
  final bool _requestIsComplete;
  final dynamic _content;

  HttpClientResponse(this._status, this._requestIsComplete, this._content);

  int get status => _status;

  bool get requestIsComplete => _requestIsComplete;

  dynamic get content => _content;
}

class HttpClient {
  static Future<HttpClientResponse> getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = response.body;
        var deserializedJson = jsonDecode(data);
        return HttpClientResponse(response.statusCode, true, deserializedJson);
      } else {
        var data = response.body;
        return HttpClientResponse(response.statusCode, true, data);
      }
    } catch (e) {
      return HttpClientResponse(500, false, null);
    }
  }
}
