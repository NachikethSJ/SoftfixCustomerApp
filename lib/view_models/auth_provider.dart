import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salon_customer_app/api/api_client.dart';
import 'package:salon_customer_app/constants/app_urls.dart';
import 'package:salon_customer_app/models/common_models/login_data_model.dart';
import 'package:salon_customer_app/models/common_models/server_error.dart';
import 'package:salon_customer_app/utils/show_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final SharedPreferences _preferences;

  bool _showLoader = false;
  bool get showLoader => _showLoader;

  LoginDataModel _userData = LoginDataModel();
  LoginDataModel get userData => _userData;

  String? _token = '';
  String? get token => _token;

  AuthProvider(this._preferences) {
    _token = _preferences.getString('token') ?? '';
    var userDetails = _preferences.getString('userDetails') ?? '';
    if (userDetails == '') {
    } else {
      Map<String, dynamic> userDetail = jsonDecode(userDetails);
      _userData = LoginDataModel.fromJson(userDetail);
    }
  }

  _setShowLoader(bool value) {
    _showLoader = value;
    notifyListeners();
  }

  bool get isUserLoggedIn {
    var userDetails = _preferences.getString('userDetails') ?? '';
    if (userDetails == '') {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> login(
      {required Map<String, dynamic> body, bool? isEmployee}) async {
    _setShowLoader(true);
    try {
      var res = await ApiClient.postApi(
        url: appUrls.loginUrl,
        body: body,
        headers: {},
      );

      showToast(res?.message, isSuccess: true);
      notifyListeners();
      _setShowLoader(false);
      return true;
    } catch (e) {
      if (e is ServerError) {
        showToast(e.message);
      }
    }
    notifyListeners();
    _setShowLoader(false);
    return false;
  }

  Future<bool> verifyOtp({required Map<String, dynamic> body}) async {
    _setShowLoader(true);
    try {
      var res = await ApiClient.postApi(
        url: appUrls.verifyOtpUrl,
        body: body,
        headers: {},
      );
      _preferences.remove('userDetails');
      _preferences.remove('token');
      _preferences.remove('userType');
      var loginData = LoginDataModel.fromJson(res?.data);

      _preferences.setString('token', loginData.token ?? '');
      _preferences.setString('userDetails', jsonEncode(loginData.toJson()));
      _preferences.setString('userType', 'vendor');
      Map<String, dynamic> userDetail =
          jsonDecode(_preferences.get('userDetails').toString());
      _userData = LoginDataModel.fromJson(userDetail);

      showToast(res?.message, isSuccess: true);
      notifyListeners();
      _setShowLoader(false);
      return true;
    } catch (e) {
      if (e is ServerError) {
        showToast(e.message ?? '');
      }
    }
    notifyListeners();
    _setShowLoader(false);
    return false;
  }

  Future<bool> logOut(
      {Map<String, String>? headers, required BuildContext context}) async {
    _setShowLoader(true);

    try {
      _preferences.remove('userDetails');
      _preferences.remove('token');
      _userData = LoginDataModel();
      _token = null;
      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      if (e is ServerError) {}
    }
    _setShowLoader(false);
    notifyListeners();
    return false;
  }

}
