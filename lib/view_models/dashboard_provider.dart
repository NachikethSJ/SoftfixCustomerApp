import 'package:flutter/material.dart';
import 'package:salon_customer_app/api/api_client.dart';
import 'package:salon_customer_app/constants/app_urls.dart';
import 'package:salon_customer_app/models/dashboard_models/near_by_service_model.dart';
import 'package:salon_customer_app/models/dashboard_models/near_by_shop_packages_model.dart';
import 'package:salon_customer_app/models/dashboard_models/near_by_shop_services_model.dart';

import 'package:salon_customer_app/utils/validate_connectivity.dart';
import 'package:salon_customer_app/view_models/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/accounts/get_booking_details_model.dart';
import '../models/booking/booking_slot_details.dart';
import '../models/booking/create_order_model.dart';
import '../models/common_models/response_model.dart';
import '../models/common_models/server_error.dart';
import '../models/dashboard_models/latest_update_model.dart';
import '../models/dashboard_models/membership_model.dart';
import '../models/dashboard_models/near_by_shop_model.dart';
import '../models/dashboard_models/packages_model.dart';
import '../models/dashboard_models/slot_booking_model.dart';
import '../models/dashboard_models/slot_by_sub_services_model.dart';
import '../models/help_model.dart';
import '../utils/show_toast.dart';

class DashboardProvider extends ChangeNotifier {
  bool _showLoader = false;
  bool get showLoader => _showLoader;

  List<NearByShopModel> _nearShopList = [];
  List<NearByShopModel> get nearShopList => _nearShopList;

  List<NearServiceModel> _serviceList = [];
  List<NearServiceModel> get serviceList => _serviceList;

  List<SubService> _subServiceList = [];
  List<SubService> get subServiceList => _subServiceList;

  List<MembershipModel> _membershipList = [];
  List<MembershipModel> get membershipList => _membershipList;

  List<PackagesModel> _packageList = [];
  List<PackagesModel> get packageList => _packageList;

  List<NearByShopServicesModel> _nearByShopServicesList = [];
  List<NearByShopServicesModel> get nearByShopServicesList => _nearByShopServicesList;

  List<NearByShopPackagesModel> _nearByShopPackagesList = [];
  List<NearByShopPackagesModel> get nearByShopPackagesList => _nearByShopPackagesList;

  //new

  List<NearByShopModel> _searchnearShopList = [];
  List<NearByShopModel> get newnearShopList => _searchnearShopList;

  List<NearServiceModel> _searchserviceList = [];
  List<NearServiceModel> get searchserviceList => _searchserviceList;

  List<SubService> _searchsubServiceList = [];
  List<SubService> get searchsubServiceList => _searchsubServiceList;

  List<MembershipModel> _searchmembershipList = [];
  List<MembershipModel> get searchmembershipList => _searchmembershipList;

  List<PackagesModel> _searchpackageList = [];
  List<PackagesModel> get searchpackageList => _searchpackageList;

  List<SlotBySubServicesModel> _slotList = [];
  List<SlotBySubServicesModel> get slotList => _slotList;

  List<GetBookingDetailsModel> _getBokingDetails = [];
  List<GetBookingDetailsModel> get getbookingDeatils => _getBokingDetails;

  List<GetLatestUpdateModel> _getLatestDetails = [];
  List<GetLatestUpdateModel> get getLatestDetails => _getLatestDetails;

  List<SlotBookingModel> _slotBooking = [];
  List<SlotBookingModel> get slotBooking => _slotBooking;

  List<SupportModel> _help = [];
  List<SupportModel> get helpuser => _help;

  CreateOrderModel _createOrderSlot = CreateOrderModel();
  CreateOrderModel get createOrderSlot => _createOrderSlot;

  List<ResponseModel> _orderSuccess = [];
  List<ResponseModel> get orerSuccess => _orderSuccess;

  List<BookSlotDetailsModel> _slotOrderDetail = [];
  List<BookSlotDetailsModel> get slotOrderDeatil => _slotOrderDetail;

  List<String> _imageList = [];
  List<String> get imageList => _imageList;

  _setShowLoader(bool value) {
    _showLoader = value;
  }

  Future<bool> getShopList({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    _setShowLoader(true);
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.postApi(
        url: appUrls.nearByShopUrl,
        body: body,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );

      _nearShopList = res?.data
          .map<NearByShopModel>((e) => NearByShopModel.fromJson(e))
          .toList();
      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      _setShowLoader(false);
      notifyListeners();
      return false;
    }
  }

  //NewNearByShopServices
  Future<bool> getNearByShopServicesList({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    _setShowLoader(true);
    _nearByShopServicesList=[];
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.postApi(
        url: appUrls.getNearByShopServicesUrl,
        body: body,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );

      _nearByShopServicesList = res?.data
          .map<NearByShopServicesModel>((e) => NearByShopServicesModel.fromJson(e))
          .toList();
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

  //NewNearByShopPackages
  Future<bool> getNearByShopPackagesList({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    _setShowLoader(true);
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.postApi(
        url: appUrls.getNearByShopPackagesUrl,
        body: body,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );

      _nearByShopPackagesList = res?.data
          .map<NearByShopPackagesModel>((e) => NearByShopPackagesModel.fromJson(e))
          .toList();
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

  //new
  Future<bool> getSearchShopList({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    _setShowLoader(true);
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.postApi(
        url: appUrls.nearByShopUrl,
        body: body,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );
      _searchnearShopList = res?.data
          .map<NearByShopModel>((e) => NearByShopModel.fromJson(e))
          .toList();
      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      _setShowLoader(false);
      notifyListeners();
      return false;
    }
  }

  Future<bool> getServiceList({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    _setShowLoader(true);
    _serviceList = [];
    _subServiceList = [];
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.postApi(
        url: appUrls.nearByServicesUrl,
        body: body,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );
      _serviceList = res?.data
          .map<NearServiceModel>((e) => NearServiceModel.fromJson(e))
          .toList();
      for (var element in _serviceList) {
        _subServiceList.addAll(element.subService ?? []);
      }
      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      _setShowLoader(false);
      notifyListeners();
      return false;
    }
  }

  //new

  Future<bool> getSearchServiceList({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    _setShowLoader(true);
    _searchserviceList = [];
    _searchsubServiceList = [];
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.postApi(
        url: appUrls.nearByServicesUrl,
        body: body,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );
      _searchserviceList = res?.data
          .map<NearServiceModel>((e) => NearServiceModel.fromJson(e))
          .toList();
      for (var element in _searchserviceList) {
        _searchsubServiceList.addAll(element.subService ?? []);
      }
      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      _setShowLoader(false);
      notifyListeners();
      return false;
    }
  }

  Future<bool> getMembershipList({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    _setShowLoader(true);
    _membershipList = [];
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.postApi(
        url: appUrls.membershipUrl,
        body: body,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );
      _membershipList = res?.data
          .map<MembershipModel>((e) => MembershipModel.fromJson(e))
          .toList();

      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      print("=====Exception=============$e");
      _setShowLoader(false);
      notifyListeners();
      return false;
    }
  }

  //new

  Future<bool> getSearchMembershipList({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    _setShowLoader(true);
    _searchmembershipList = [];
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.postApi(
        url: appUrls.membershipUrl,
        body: body,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );
      _searchmembershipList = res?.data
          .map<MembershipModel>((e) => MembershipModel.fromJson(e))
          .toList();

      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      print("=====Exception=============$e");
      _setShowLoader(false);
      notifyListeners();
      return false;
    }
  }

  Future<bool> getPackagesList({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    _setShowLoader(true);
    _packageList = [];
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.postApi(
        url: appUrls.packagesUrl,
        body: body,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );
      _packageList = res?.data
          .map<PackagesModel>((e) => PackagesModel.fromJson(e))
          .toList();

      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      print("=====Exception=============$e");
      _setShowLoader(false);
      notifyListeners();
      return false;
    }
  }

  //new

  Future<bool> getSearchPackagesList({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    _setShowLoader(true);
    _searchpackageList = [];
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.postApi(
        url: appUrls.packagesUrl,
        body: body,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );
      _searchpackageList = res?.data
          .map<PackagesModel>((e) => PackagesModel.fromJson(e))
          .toList();

      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      _setShowLoader(false);
      notifyListeners();
      return false;
    }
  }

  Future<bool> getSlotList({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    _setShowLoader(true);
    _slotList = [];
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.postApi(
        url: appUrls.slotsBySubService,
        body: body,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );
      _slotList = res?.data
          .map<SlotBySubServicesModel>(
              (e) => SlotBySubServicesModel.fromJson(e))
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

  Future<bool> bookingDetails({
    required BuildContext context,
  }) async {
    _setShowLoader(true);
    _getBokingDetails = [];
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.getApi(
        url: appUrls.getBookingDetails,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );
      _getBokingDetails = res?.data
          .map<GetBookingDetailsModel>(
              (e) => GetBookingDetailsModel.fromJson(e))
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

  Future<bool> SlotBooking({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    _setShowLoader(true);
    _slotBooking = [];
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.postApi(
        url: appUrls.slotBooking,
        body: body,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );
      _slotBooking = res?.data
          .map<SlotBookingModel>((e) => SlotBookingModel.fromJson(e))
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

  Future<bool> help({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    _setShowLoader(true);
    _help = [];
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.postApi(
        url: appUrls.help,
        body: body,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );

      if (res?.data is List) {
        _help = (res?.data as List<dynamic>)
            .map<SupportModel>((e) => SupportModel.fromJson(e))
            .toList();
        // validateConnectivity(context: context, provider: provider)
        print("dfhjfghdsgfhsdfsdh");
        showToast("Thanks for contacting us. We will look soon!",
            isSuccess: true);
      } else {
        _setShowLoader(false);
        showToast("Thanks for contacting us. We will look soon!",
            isSuccess: true);
        // Handle the case where res?.data is not a List
        print('Response data is not a List');
      }
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

  Future<bool> createOrder({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    _setShowLoader(true);
    _createOrderSlot = CreateOrderModel();
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
      _createOrderSlot = CreateOrderModel.fromJson(res?.data);

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

  Future<bool> orderSuccess({
    required BuildContext context,
    required String orderId,
  }) async {
    _orderSuccess = [];
    _setShowLoader(true);
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.getApi(
        url: '${appUrls.getOrder}/$orderId',
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );
      _orderSuccess = res?.data
          .map<ResponseModel>((e) => ResponseModel.fromJson(e))
          .toList();
      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      _setShowLoader(false);
      notifyListeners();
      return false;
    }
  }

  Future<bool> orderSlotDetail({
    required BuildContext context,
    required String orderId,
  }) async {
    _slotOrderDetail = [];
    _setShowLoader(true);
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.getApi(
        url: '${appUrls.getOrderDetails}/$orderId',
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );
      _slotOrderDetail = res?.data
          .map<BookSlotDetailsModel>((e) => BookSlotDetailsModel.fromJson(e))
          .toList();
      _setShowLoader(false);
      notifyListeners();
      return true;
    } catch (e) {
      _setShowLoader(false);
      notifyListeners();
      return false;
    }
  }

  Future<bool> latestDetails({
    required BuildContext context,
  }) async {
    _setShowLoader(true);
    _imageList = [];
    _getLatestDetails = [];
    notifyListeners();
    try {
      var state = AuthProvider(await SharedPreferences.getInstance());
      var res = await ApiClient.getApi(
        url: appUrls.getLatestUpdate,
        headers: {
          'Authorization': 'Bearer ${state.userData.token ?? ''}',
        },
      );
      _getLatestDetails = res?.data
          .map<GetLatestUpdateModel>((e) => GetLatestUpdateModel.fromJson(e))
          .toList();
      _getLatestDetails.forEach((element) {
        print("Image Url==${element.imageUrl}");
        if (element.imageUrl != null) {
          _imageList.add(element.imageUrl?[0]?.toString() ?? '');
        }
      });

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
