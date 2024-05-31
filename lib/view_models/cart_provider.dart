import 'package:flutter/cupertino.dart';
import 'package:salon_customer_app/models/common_models/response_model.dart';
import 'package:salon_customer_app/models/common_models/server_error.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../constants/app_urls.dart';
import '../models/booking/create_order_model.dart';
import '../models/cart/cart_details_model.dart';
import '../models/dashboard_models/get_notification_model.dart';
import '../models/help_model.dart';
import '../utils/show_toast.dart';
import 'auth_provider.dart';

class CartProvider extends ChangeNotifier {
  bool _showLoader = false;

  bool get showLoader => _showLoader;

  List<SupportModel> _addCart = [];
  List<SupportModel> get addCartItem => _addCart;

  List<CartDetailsModel> _cartDetail = [];
  List<CartDetailsModel> get showCartDetails => _cartDetail;

  List<ResponseModel> _deleteCart = [];
  List<ResponseModel> get deleteCartItem => _deleteCart;

  List<ResponseModel> _updateCart = [];
  List<ResponseModel> get UpdateCartItem => _updateCart;

  List<GetNotificationListModel> _notificationDetail = [];
  List<GetNotificationListModel> get showNotificationDetails => _notificationDetail;

  CreateOrderModel _createOrderSlotForCart = CreateOrderModel();
  CreateOrderModel get createOrderSlot => _createOrderSlotForCart;

  _setShowLoader(bool value) {
    _showLoader = value;
  }

  Future<bool> addCart({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    _setShowLoader(true);

    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.postApi(
        url: appUrls.addCart,
        body: body,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );
     showToast(res?.message,isSuccess: true);
      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      if (e is ServerError) {
        print("=====Exception===${e.message}");
        showToast(e.message);
      }
      _setShowLoader(false);
      notifyListeners();
      return false;
    }
  }

  Future<bool> cartDetails({
    required BuildContext context,
  }) async {
    _setShowLoader(true);
    _cartDetail = [];
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.getApi(
        url: appUrls.getCartDetails,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );
      print("============ResponseSlotsTime===${res?.data}");
      _cartDetail = res?.data
          .map<CartDetailsModel>((e) => CartDetailsModel.fromJson(e))
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

  Future<bool> deleteToCart({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    _setShowLoader(true);
    _deleteCart = [];
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.postApi(
        url: appUrls.deleteCart,
        body: body,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );

      if (res?.data is List) {
        _deleteCart = (res?.data as List<dynamic>)
            .map<ResponseModel>((e) => ResponseModel.fromJson(e))
            .toList();

        // validateConnectivity(context: context, provider: provider)
        print("dfhjfghdsgfhsdfsdh");
        showToast(res?.message, isSuccess: true);
      } else {
        _setShowLoader(false);
        showToast(res?.message, isSuccess: true);
        // Handle the case where res?.data is not a List
        print('Response data is not a List');
      }
      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      print("=====Exception===$e");
      if (e is ServerError) {
        showToast(e.message);
      }
      _setShowLoader(false);
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateToCart({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    _setShowLoader(true);
    _updateCart = [];
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.putApi(
        url: appUrls.updateCart,
        body: body,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );

      if (res?.data is List) {
        _updateCart = (res?.data as List<dynamic>)
            .map<ResponseModel>((e) => ResponseModel.fromJson(e))
            .toList();
        print("dfhjfghdsgfhsdfsdh");
        showToast(res?.message, isSuccess: true);
      } else {
        _setShowLoader(false);
        showToast(res?.message, isSuccess: true);
// Handle the case where res?.data is not a List
        print('Response data is not a List');
      }
      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      print("=====Exception===$e");
      if (e is ServerError) {
        showToast(e.message);
      }
      _setShowLoader(false);
      notifyListeners();
      return false;
    }
  }

  Future<bool> notificationDetails({
    required BuildContext context,
  }) async {
    _setShowLoader(true);
    _notificationDetail = [];
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.getApi(
        url: appUrls.appNotification,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );
      print("============Response====${res?.data}");
      _notificationDetail = res?.data
          .map<GetNotificationListModel>((e) => GetNotificationListModel.fromJson(e))
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


  ///_createOrderSlotForCart
  Future<bool> createOrder({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    // _setShowLoader(true);
    _createOrderSlotForCart = CreateOrderModel();
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.postApi(
        url: appUrls.createOrder,
        body: body,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );
      _createOrderSlotForCart = CreateOrderModel.fromJson(res?.data);

      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      print("=====Exception=============$e");
      if (e is ServerError) {
        showToast(e.message);
      }
      _setShowLoader(false);
      notifyListeners();
      return false;
    }
  }
}
