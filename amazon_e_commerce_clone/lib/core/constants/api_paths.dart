class ApiPaths{

  static const String apiKey = "";
  static const String baseUrl = "http://<your ip>:3000/api";

  //paths
  // auth
  static const String signupPath = "/signup";
  static const String signinPath = "/signin";
  static const String signOutPath = "/signout";
  static const String verifyTokenPath = "/validate-token";
  static const String getUserDataPath = "/";
  // general
  static const String getCategoryProductsPath = "/products";
  // admin
  static const String adminAddProductPath = "/admin/add-product";
  static const String adminDeleteProductPath = "/admin/delete-product";
  static const String adminGetProductsPath = "/admin/get-products";
  static const String adminGetOrdersPath = "/admin/get-orders";
  static const String adminChangeOrderStatus = "/admin/change-order-status";
  static const String adminGetEarnings = "/admin/analytics";
  // user
  static const String userGetSearchResults = "/products/search";
  static const String userRateProduct = "/rate-product";
  static const String userDealOfTheDay = "/deal-of-the-day";
  static const String userAddToCart = "/add-to-cart";
  static const String userRemoveFromCart = "/remove-from-cart";
  static const String userUpdateUserAddress = "/update-user-address";
  static const String userOrder = "/order";
  static const String userGetAllOrders = "/orders/me";


  static String signupUrl() => "$baseUrl$signupPath";
  static String signinUrl() => "$baseUrl$signinPath";
  static String signOutUrl() => "$baseUrl$signOutPath";
  static String updateUserAddressUrl() => "$baseUrl$userUpdateUserAddress";
  static String verifyTokenUrl() => "$baseUrl$verifyTokenPath";
  static String getUserDataUrl() => "$baseUrl$getUserDataPath";
  static String adminAddProductUrl() => "$baseUrl$adminAddProductPath";
  static String adminDeleteProductUrl() => "$baseUrl$adminDeleteProductPath";
  static String adminGetProductsUrl() => "$baseUrl$adminGetProductsPath";
  static String adminGetOrdersUrl() => "$baseUrl$adminGetOrdersPath";
  static String adminChangeOrderStatusUrl() => "$baseUrl$adminChangeOrderStatus";
  static String adminGetEarningsUrl() => "$baseUrl$adminGetEarnings";
  static String getCategoryProductsUrl() => "$baseUrl$getCategoryProductsPath";
  static String getSearchResultsUrl() => "$baseUrl$userGetSearchResults";
  static String rateProductUrl() => "$baseUrl$userRateProduct";
  static String getDealOfTheDayUrl() => "$baseUrl$userDealOfTheDay";
  static String addToCartUrl() => "$baseUrl$userAddToCart";
  static String removeFromCartUrl() => "$baseUrl$userRemoveFromCart";
  static String orderUrl() => "$baseUrl$userOrder";
  static String getAllOrdersUrl() => "$baseUrl$userGetAllOrders";

}