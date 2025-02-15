class ApiSettings {
  static const String baseUrl = "http://147.93.63.182/api/";

  /// User
  static const String login = "${baseUrl}login";
  static const String logout = "${baseUrl}logout";
//static const String resetPassword = "${baseUrl}users/{id}/reset-password";   //Admin
  static const String changePassword = "${baseUrl}user/password";   //Customer
  static const String changeMobileNumber = "${baseUrl}user/mobile";
  static const String updateInfo = "${baseUrl}users/{{{id}}}";
  static const String deleteAccount = "${baseUrl}users/{{id}}";
  static const String userToken = "${baseUrl}user/token";

  /// Ads
  static const String getAds = "${baseUrl}ads";
  //static const String getAsdById = "${baseUrl}ads/{{id}";

  /// Places
  static const String getPlaces = "${baseUrl}places";
  static const String getPlacesById = "${baseUrl}places/{id}";

  /// Containers
  //View customer container list  للادمن
 // View container for himself  للكستمر
  static const String getContainersForHimself = "${baseUrl}user/containers";
  // static const String getCustomerContainersList = "${baseUrl}users/{{id}}/containers";

/// Account Statement
  static const String getStatementById = "${baseUrl}users/{{id}}/account-statments";
}
