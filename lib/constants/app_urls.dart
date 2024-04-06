class AppUrls {
  String get baseUrl => 'http://51.21.129.106:5000';

  //local...
  // String get baseUrl => 'http://192.168.29.1';



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



}

AppUrls appUrls = AppUrls();
