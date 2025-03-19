class ApiConstants {
  static const String baseUrl = 'https://be.hny.elementron.xyz/';
  static const int connectionTimeout = 30;
  static const int receiveTimeout = 30;

  // API endpoints
  static const String login = 'login_customer';
  static const String otpVerify = 'otp_verify_customer';
  static const String getCartDataListUrl = 'get_home_page';
  static const String fileUploadApiUrl = 'files_upload';
  static const String updateCustomerUrl = 'update_customer';
  static const String getProfileDetails = 'get_customer_by_id';
  static const String getTypeListUrl = 'get_type_list';
  static const String getAddOnList = 'get_list_add_on';
  static const String getBookingListUrl = 'get_list_reservation';
  static const String addToFavourites = 'addto_favourite';
  static const String removeFavourites = 'remove_favourite';
  static const String getFavouritesList = 'get_list_favourite';
  static const String createCart = 'create_cart';
  static const String getCart = 'get_cart';
    static const String createReservation = 'create_reservation';
    static const String updateBookingLocation = 'update_booking_item';



  
}
