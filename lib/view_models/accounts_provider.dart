import 'package:flutter/cupertino.dart';
import 'package:salon_customer_app/models/common_models/server_error.dart';
import 'package:salon_customer_app/models/help/get_help_message_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../constants/app_urls.dart';
import '../models/booking/booking_history_detail_model.dart';
import '../models/booking/get_latest_otp_model.dart';
import '../models/help_model.dart';
import '../utils/show_toast.dart';
import 'auth_provider.dart';

class AccountsProvider extends ChangeNotifier {
  bool _showLoader = false;

  bool get showLoader => _showLoader;

  List<SupportModel> _review = [];
  List<SupportModel> get reviewuser => _review;

  List<BookingDetailListModel> _bookingDetail = [];
  List<BookingDetailListModel> get showbookingDetails => _bookingDetail;

  List<BookingDetailListModel> _bookingDetailHistory = [];
  List<BookingDetailListModel> get bookingDetailHistory => _bookingDetailHistory;

  List<GetHelpMessageModel> _getHelpMessageDetail = [];
  List<GetHelpMessageModel> get getHelpMessageList => _getHelpMessageDetail;

  GetLatestOTPModel _getLatestOTP = GetLatestOTPModel();
  GetLatestOTPModel get getLatestOTP => _getLatestOTP;

  _setShowLoader(bool value) {
    _showLoader = value;
  }

  Future<bool> review({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    _setShowLoader(true);
    _review = [];
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.postApi(
        url: appUrls.review,
        body: body,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );

      if (res?.data is List) {
        _review = (res?.data as List<dynamic>)
            .map<SupportModel>((e) => SupportModel.fromJson(e))
            .toList();
        // validateConnectivity(context: context, provider: provider)
        print("dfhjfghdsgfhsdfsdh");
        showToast(
           res?.message, isSuccess: true);
      } else {
        _setShowLoader(false);
        showToast(
            res?.message, isSuccess: true);
        // Handle the case where res?.data is not a List
        print('Response data is not a List');
      }
      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      print("=====Exception===$e");
      if(e is ServerError){
        showToast(e.message);
      }
      _setShowLoader(false);
      notifyListeners();
      return false;
    }
  }


  Future<bool> bookingHistoryDetails({
    required BuildContext context,
  }) async {
    _setShowLoader(true);
    _bookingDetail = [];
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.getApi(
        url: appUrls.bookingDetailList,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );
      print("============Response====${res?.data}");
      _bookingDetail = res?.data['incompleteBookings']
          .map<BookingDetailListModel>((e) => BookingDetailListModel.fromJson(e))
          .toList();
      _bookingDetailHistory=res?.data['completedBookings']
          .map<BookingDetailListModel>((e) => BookingDetailListModel.fromJson(e))
          .toList();

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


  Future<bool> getHelpMessageDetail({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async{
    _setShowLoader(true);
    _getHelpMessageDetail = [];
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.postApi(
        url: appUrls.getHelpMessage,
        body: body,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );
      if(res?.data is List) {
        _getHelpMessageDetail = (res?.data as List<dynamic>).map<GetHelpMessageModel>((e) => GetHelpMessageModel.fromJson(e))
            .toList();
        print("====Help Message===");
        showToast(
            res?.message, isSuccess: true);
      } else {
        _setShowLoader(false);
        showToast(
            res?.message, isSuccess: true);
        // Handle the case where res?.data is not a List
        print('Response data is not a List');
      }
      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      print("=====Exception===$e");
      if(e is ServerError){
        showToast(e.message);
      }
      _setShowLoader(false);
      notifyListeners();
      return false;
    }
  }

  ///GetLatestOTP
  Future<bool> getLatestOTPView({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async{
    _setShowLoader(true);
    //_getLatestOTP = GetLatestOTPModel();
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.postApi(
        url: appUrls.getLatestOTP,
        body: body,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );
      _getLatestOTP = GetLatestOTPModel.fromJson(res?.data);

      _setShowLoader(false);
      notifyListeners();
      return true;
      /*if(res?.data is List) {
        _getLatestOTP = (res?.data as List<dynamic>).map<GetLatestOTPModel>((e) => GetLatestOTPModel.fromJson(e))
            .toList();
        print("====OTP====");
        showToast(
            res?.message, isSuccess: true);
      } else {
        _setShowLoader(false);
        showToast(
            res?.message, isSuccess: true);
        // Handle the case where res?.data is not a List
        print('Response data is not a List');
      }
      _setShowLoader(false);
      notifyListeners();
      return true;*/
    } catch (e) {
      print("=====Exception===$e");
      if(e is ServerError){
        showToast(e.message);
      }
      _setShowLoader(false);
      notifyListeners();
      return false;
    }
  }

}
