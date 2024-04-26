import 'package:flutter/cupertino.dart';
import 'package:salon_customer_app/models/common_models/server_error.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../constants/app_urls.dart';
import '../models/booking/booking_history_detail_model.dart';
import '../models/dashboard_models/membership_details_model.dart';
import '../models/dashboard_models/package_detail_model.dart';
import '../models/dashboard_models/service_detail_model.dart';
import '../models/help_model.dart';
import '../utils/show_toast.dart';
import 'auth_provider.dart';

class ServicesDetailsProvider extends ChangeNotifier {
  bool _showLoader = false;

  bool get showLoader => _showLoader;

  GetMemberShipDetailsModel _memberShipDetail = GetMemberShipDetailsModel();
  GetMemberShipDetailsModel get showMemberShipDetails => _memberShipDetail;

  GetPackageDetailsModel _packageDetail = GetPackageDetailsModel();
  GetPackageDetailsModel get showPackageDetails => _packageDetail;

  GetServiceDetailsModel _serviceDetail =GetServiceDetailsModel();
  GetServiceDetailsModel get showServiceDetail => _serviceDetail;

  _setShowLoader(bool value) {
    _showLoader = value;
  }



  Future<bool> memberShipDetail({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    _setShowLoader(true);
    _memberShipDetail = GetMemberShipDetailsModel();
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.postApi(
        url: appUrls.getMemberShipUrl,
        body: body,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );
      _memberShipDetail = GetMemberShipDetailsModel.fromJson(res?.data);

      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      print("=====Exception===$e");
      _setShowLoader(false);
      notifyListeners();
      return false;
    }
  }



  Future<bool> packageDetail({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    _setShowLoader(true);
    _packageDetail = GetPackageDetailsModel();
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.postApi(
        url: appUrls.getPackageUrl,
        body: body,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );
      _packageDetail = GetPackageDetailsModel.fromJson(res?.data);

      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      print("=====Exception===$e");
      _setShowLoader(false);
      notifyListeners();
      return false;
    }
  }



  Future<bool> serviceDetail({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    _setShowLoader(true);
    _serviceDetail = GetServiceDetailsModel();
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.postApi(
        url: appUrls.getServiceDetailUrl,
        body: body,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );
      _serviceDetail = GetServiceDetailsModel.fromJson(res?.data);

      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      print("=====Exception===$e");
      _setShowLoader(false);
      notifyListeners();
      return false;
    }
  }

}
