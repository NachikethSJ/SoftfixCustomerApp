// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:salon_customer_app/constants/app_urls.dart';
import 'package:salon_customer_app/models/common_models/response_model.dart';
import 'package:salon_customer_app/models/common_models/server_error.dart';
import 'package:salon_customer_app/screens/auth_screens/login.dart';
import 'package:salon_customer_app/utils/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  static Future<ResponseModel?> postApi(
      {BuildContext? context,
      required String url,
      required Map<String, dynamic> body,
      Map<String, String>? headers}) async {
    debugPrint('Url: ${appUrls.baseUrl + url}');
    debugPrint('body: $body');
    headers?["Content-Type"] = "application/json";
    debugPrint('Headers: $headers');

    http.Response response = await http.post(
      Uri.parse(appUrls.baseUrl + url),
      headers: headers,
      body: jsonEncode(body),
    );
    debugPrint("data: ${response.body}");
    if (response.statusCode == 200) {
      var data = ResponseModel.fromJson(jsonDecode(response.body));
      return data;
    } else if (response.statusCode == 401) {
      var pref = await SharedPreferences.getInstance();
      pref.remove("userDetails");
      navigateRemoveUntil(context: context!, to: const Login());
    } else {
      throw ServerError(
          response.statusCode,
          jsonDecode(response.body)['msg'] ??
              jsonDecode(response.body)['message']);
    }
    return null;
  }

  static Future<ResponseModel?> getApi(
      {BuildContext? context,
      required String url,
      Map<String, String>? headers}) async {
    debugPrint('Url: ${appUrls.baseUrl + url}');
    debugPrint('Headers: $headers');

    http.Response response = await http.get(
      Uri.parse(
        appUrls.baseUrl + url,
      ),
      headers: headers,
    );
    debugPrint("data: ${response.body}");
    if (response.statusCode == 200) {
      var data = ResponseModel.fromJson(jsonDecode(response.body));
      return data;
    } else if (response.statusCode == 401) {
      var pref = await SharedPreferences.getInstance();
      pref.remove("userDetails");
      navigateRemoveUntil(context: context!, to: const Login());
    } else {
      throw ServerError(response.statusCode, jsonDecode(response.body)['msg']);
    }
    return null;
  }

  static Future<ResponseModel?> putApi(
      {BuildContext? context,
      required String url,
      required Map<String, dynamic> body,
      Map<String, String>? headers}) async {
    debugPrint('Url: ${appUrls.baseUrl + url}');
    debugPrint('body: $body');
    headers?["Content-Type"] = "application/json";
    debugPrint('Headers: $headers');

    http.Response response = await http.put(
      Uri.parse(
        appUrls.baseUrl + url,
      ),
      headers: headers,
      body: jsonEncode(body),
    );
    debugPrint("data: ${response.body}");
    if (response.statusCode == 200) {
      var data = ResponseModel.fromJson(jsonDecode(response.body));
      return data;
    } else if (response.statusCode == 401) {
      var pref = await SharedPreferences.getInstance();
      pref.remove("userDetails");
      navigateRemoveUntil(context: context!, to: const Login());
    } else {
      throw ServerError(response.statusCode, jsonDecode(response.body)['msg']);
    }
    return null;
  }

  static Future<ResponseModel?> deleteApi(
      {BuildContext? context,
      required String url,
      required Map<String, dynamic> body,
      Map<String, String>? headers}) async {
    debugPrint('Url: ${appUrls.baseUrl + url}');
    headers?["Content-Type"] = "application/json";
    debugPrint('Headers: $headers');

    http.Response response = await http.delete(
        Uri.parse(
          appUrls.baseUrl + url,
        ),
        headers: headers,
        body: jsonEncode(body));
    debugPrint("data: ${response.body}");
    if (response.statusCode == 200) {
      var data = ResponseModel.fromJson(jsonDecode(response.body));
      return data;
    } else if (response.statusCode == 401) {
      var pref = await SharedPreferences.getInstance();
      pref.remove("userDetails");
      navigateRemoveUntil(context: context!, to: const Login());
    } else {
      throw ServerError(response.statusCode, jsonDecode(response.body)['msg']);
    }
    return null;
  }

  static Future<dynamic> multipartApi(
      {required BuildContext context,
      required String url,
      required File file,
      required Map<String, String> body,
      required String imageKey,
      required Map<String, String> headers}) async {
    debugPrint('Url: ${appUrls.baseUrl + url}');
    debugPrint('Path: ${file.path}');

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        appUrls.baseUrl + url,
      ),
    );
    request.headers.addAll(headers);
    request.fields.addAll(body);

    request.files.add(await http.MultipartFile.fromPath(
      imageKey,
      file.path,
      filename: file.path,
      contentType: MediaType('image', 'jpeg'),
    ));

    debugPrint('body: $body');

    http.StreamedResponse response = await request.send();
    var result = await response.stream.bytesToString();
    debugPrint("data: $result");

    if (response.statusCode == 200) {
      var data = ResponseModel.fromJson(jsonDecode(result));
      return data;
    } else if (response.statusCode == 401) {
      var pref = await SharedPreferences.getInstance();
      pref.remove("userDetails");
      navigateRemoveUntil(context: context, to: const Login());
    } else {
      throw ServerError(response.statusCode, jsonDecode(result)['msg']);
    }
  }
}
