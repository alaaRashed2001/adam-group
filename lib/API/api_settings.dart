class ApiSettings {
  static const String baseUrl = "https://adamgroup.ps/api/";

  /// Tracking
  static const String trackingApiKey = "K-7B90D58A-F456-46B5-B8B4-FDD224EC25F8";
  static const String trackingBaseUrl = "https://tracking.searates.com/";

  static const String getTracking = "${trackingBaseUrl}tracking?api_key=$trackingApiKey&number={{number}}&sealine=auto&force_update=false&route=false&ais=false";
  /// User
  static const String login = "${baseUrl}login";
  static const String logout = "${baseUrl}logout";
  static const String changePassword = "${baseUrl}user/password";   //Customer
  static const String changeMobileNumber = "${baseUrl}user/mobile";
  static const String updateInfo = "${baseUrl}users/{{{id}}}";
  static const String deleteAccount = "${baseUrl}users/{{id}}";
  static const String userToken = "${baseUrl}user/token";

  /// Ads
  static const String getAds = "${baseUrl}ads";

  /// Places
  static const String getPlaces = "${baseUrl}places";
  static const String getPlacesById = "${baseUrl}places/{id}";

  /// Containers
  static const String getContainersForHimself = "${baseUrl}user/containers";

/// Account Statement
  static const String getStatementById = "${baseUrl}users/{{id}}/account-statments";

  /// Notifications
  static const String getNotifications= "${baseUrl}notifications";

}
