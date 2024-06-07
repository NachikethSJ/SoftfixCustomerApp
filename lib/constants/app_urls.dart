class AppUrls {
  // String get baseUrl => 'http://51.21.129.106:5000';

    String get baseUrl => 'http://13.50.84.221:5000';

  ///local...
  ///String get baseUrl => 'http://192.168.29.202:3000';



  String get loginUrl => '/user/login';

  String get verifyOtpUrl => '/user/otp-verify';

  String get nearByShopUrl => '/user/near-by-shop';

  String get nearByServicesUrl => '/user/near-by-services';

  String get membershipUrl => '/user/near-by-memberships';

  String get packagesUrl => '/user/near-by-packages';

  String get nearByElements => '/near-by-elements';

 String get slotsBySubService => '/user/get-slots-by-sub-service';

 String get getBookingDetails => '/user/getBookingDetailList';

 String get slotBooking => '/user/bookingdetails';

 String get help => '/user/storesupportusers';


 String get review=> '/user/createreview';

 String get  createOrder=> '/user/createOrder';

 String get  addCart=> '/user/addToCart';

 String get  getCartDetails=> '/user/getCartLists';

 String get  deleteCart=> '/user/cart/delete';

 String get  updateCart=> '/user/cart';

 String get  getOrder=> '/user/getOrder';

 String get getOrderDetails=> '/user/getOrderDetails';

 String get bookingDetailList => '/user/getBookingDetailList';

 String get appNotification => '/user/app-notification';

 String get readUnreadNotification => '/user/read-unread-notification';

 String get deleteNotification => '/user/delete-notification';

 String get getLatestUpdate => '/user/getlatestUpdates/';

 String get getServiceDetailUrl => '/user/getlatestUpdates/service';

 String get getMemberShipUrl => '/user/getlatestUpdates/membership';

 String get getPackageUrl => '/user/getlatestUpdates/package';

 String get getSubServiceDetailUrl => '/user/getlatestUpdates/subService';

 String get getHelpMessage => '/user/getAllQueries';

 String get getNearByShopServicesUrl => '/user/get-services-by-shop';

 String get getNearByShopPackagesUrl => '/user/get-packages-by-shop';

 String get getNearByShopMembershipUrl => '/user/get-membership-by-shop';

 String get searchByShopServicesUrl => 'user/search';
}

AppUrls appUrls = AppUrls();
