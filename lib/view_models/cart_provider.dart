import 'package:flutter/cupertino.dart';
import 'package:salon_customer_app/models/common_models/server_error.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../constants/app_urls.dart';
import '../models/cart/cart_details_model.dart';
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

  _setShowLoader(bool value) {
    _showLoader = value;
  }

  Future<bool> addCart({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    _setShowLoader(true);
    _addCart = [];
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

      if (res?.data is List) {
        _addCart = (res?.data as List<dynamic>)
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


  Future<bool> cartDetails({
    required BuildContext context,
  }) async {
    _setShowLoader(true);
    _cartDetail = [];
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.getApi(
        url: appUrls.getBookingDetails,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );
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

}